# -*- coding: utf-8 -*-
import cv2, json
import numpy as np

def voc_ap(recall, precision, use_07_metric=False):
    if use_07_metric:
        # 11 point metric
        ap = 0.
        for t in np.arange(0.,1.1,0.1):
            if np.sum(recall >= t) == 0:
                p = 0
            else:
                p = np.max(precision[recall>=t])
            ap = ap + p/11.
    else:
        # correct ap caculation
        mrec = np.concatenate(([0.], recall, [1.]))
        mpre = np.concatenate(([0.], precision, [0.]))

        for i in range(mpre.size -1, 0, -1):
            mpre[i-1] = np.maximum(mpre[i-1],mpre[i])

        i = np.where(mrec[1:] != mrec[:-1])[0]

        ap = np.sum((mrec[i + 1] - mrec[i]) * mpre[i + 1])

    return ap

def bbox_iou(box1, box2):
    """
    Returns the IoU of two bounding boxes
    """
    # Get the coordinates of bounding boxes
    b1_x1, b1_y1, b1_x2, b1_y2 = box1[:, 0], box1[:, 1], box1[:, 2], box1[:, 3]
    b2_x1, b2_y1, b2_x2, b2_y2 = box2[:, 0], box2[:, 1], box2[:, 2], box2[:, 3]

    # get the corrdinates of the intersection rectangle
    inter_rect_x1 = np.maximum(b1_x1, b2_x1)
    inter_rect_y1 = np.maximum(b1_y1, b2_y1)
    inter_rect_x2 = np.minimum(b1_x2, b2_x2)
    inter_rect_y2 = np.minimum(b1_y2, b2_y2)
    # Intersection area
    inter_area = np.clip(inter_rect_x2 - inter_rect_x1 + 1, 0, 1e5) * \
                np.clip(inter_rect_y2 - inter_rect_y1 + 1, 0, 1e5)
    # Union Area
    b1_area = (b1_x2 - b1_x1 + 1) * (b1_y2 - b1_y1 + 1)
    b2_area = (b2_x2 - b2_x1 + 1) * (b2_y2 - b2_y1 + 1)

    iou = inter_area / (b1_area + b2_area - inter_area + 1e-16)

    return iou

class DetectorTools:
    def __init__(self, detector):
        self.detector = detector

    def inference(self, input_, preprocess=None):
        """inference one image, get det: [[x1,y1,x2,y2,cls,prob], ...],
        which has been scaled to image"""
        if isinstance(input_, str):
            image = cv2.imread(input_)
            assert image is not None, input_
        else:
            image = input_

        if preprocess is not None:
            image = preprocess(image)
        return image, self.detector([image])[0]

    @staticmethod
    def nms(dets, nms_thresh=0.5, match_cls=True, is_merge=True):
        """ Non-Maximum Suppression to further filter detections.
        dets: [[x1, y1, x2, y2, cls_id, prob], ...]
        """
        if not len(dets):
            return dets

        # Sort by it
        dets = dets[np.argsort(-dets[:, -1])]
        # Perform non-maximum suppression
        output = []
        while len(dets):
            large_overlap = bbox_iou(dets[:1, :4], dets[:, :4]) > nms_thresh
            if match_cls:
                label_match = dets[0, -1] == dets[:, -1]
            else:
                label_match = 1

            # Indices of boxes with lower confidence scores, large IOUs and matching labels
            invalid = large_overlap & label_match
            # Merge overlapping bboxes by order of confidence
            if match_cls and is_merge:
                ivdet = dets[invalid]
                ivprobs = ivdet[:, -1:]
                dets[0, :4] = (ivprobs * dets[invalid, :4]).sum(0) / ivprobs.sum()

            output += [dets[0]]
            dets = dets[invalid == 0]

        return np.array(output, dtype=dets.dtype)

    @staticmethod
    def draw_box(img, dets, classes, colors, thresh=0.5):
        """Draw detected bounding boxes.
        dets: [[x1, y1, x2, y2, cls_id, prob], ...]
        """
        h, w = img.shape[:2]
        for det in dets:
            score = det[-1]
            if score < thresh: continue

            x1, y1, x2, y2, cid = np.int32(det[:5])
            cls = classes[cid]
            color = colors[cls]

            cv2.rectangle(img, (x1,y1), (x2,y2), color, 2)
            cv2.putText(img, '{:s} {:.3f}'.format(cls, score), (x1+2,y1+15),
                    cv2.FONT_HERSHEY_SIMPLEX, .45, (0,0,255))
        return img

    @staticmethod
    def voc_eval(targets, predicts, classes, iou_th=0.5, prob_th=0.01, use_07_metric=False):
        """
        get mAP: https://www.zhihu.com/question/53405779
        targets: [[file,x1,y1,x2,y2,cls], ...]
        predicts: [[file,x1,y1,x2,y2,cls, prob], ...]
        """

        def parse_target(targets):
            """out: {0: {imgfile: [[x1,y1,x2,y2], ...], ...}, ...}"""
            out = {}
            for ann in targets:
                f, c, bbox = ann[0], int(ann[5]), ann[1:5]
                out.setdefault(int(c), {})
                out[c].setdefault(f, [])
                out[c][f].append(bbox)
            return out

        def parse_predict(predicts):
            """out: {0:[[imgfile,x1,y1,x2,y2,cls,prob],...], 1:[[],...]}"""
            out = {}
            for ann in predicts:
                f, c = ann[0], int(ann[5])
                out.setdefault(c, [])
                out[c].append(ann)
            return out

        targets = parse_target(targets)
        predicts = parse_predict(predicts)

        aps = {}
        print(targets.keys(), len(targets))
        for cls, cls_name in enumerate(classes):
            targets_cls = targets.get(cls)  # {file1: [box1,box2,...], file2:...}
            preds_cls = predicts.get(cls)
            # 如果这个类别一个都没有检测到的异常情况
            if targets_cls is None:
                print('---class {} ap {}'.format(cls_name, -1))
                continue
            if not preds_cls or len(preds_cls) == 0:
                aps[cls_name] = 0
                print('---class {} ap {}'.format(cls_name, aps[cls_name]))
                continue

            num_targets = float(sum(len(b) for b in targets_cls.values()))

            # probs从大到小排序，对应到tp
            order = np.argsort([r[-1] for r in preds_cls])[::-1]

            tp = []  # true predict
            for pred in (preds_cls[i] for i in order):  # bbox: [file,x1,y1,x2,y2]
                tp.append(0)

                bbox = pred[:5]
                prob = pred[-1]
                if prob < prob_th:
                    continue

                imgfile = bbox[0]
                pdbox = np.int32(bbox[1:])

                gtboxes = targets_cls.get(imgfile) or []  # gt: ground truth
                for gtbox in gtboxes:
                    # compute overlaps between to box(IoU)
                    ixmin = np.maximum(gtbox[0], pdbox[0])
                    iymin = np.maximum(gtbox[1], pdbox[1])
                    ixmax = np.minimum(gtbox[2], pdbox[2])
                    iymax = np.minimum(gtbox[3], pdbox[3])
                    iw = np.maximum(ixmax - ixmin + 1., 0.)
                    ih = np.maximum(iymax - iymin + 1., 0.)
                    inters = iw * ih

                    union = (pdbox[2]-pdbox[0]+1.)*(pdbox[3]-pdbox[1]+1.) + (gtbox[2]-gtbox[0]+1.)*(gtbox[3]-gtbox[1]+1.) - inters
                    if union == 0:
                        print('error:', pdbox, gtbox)

                    overlaps = inters/union
                    if overlaps > iou_th:
                        tp[-1] = 1
                        gtboxes.remove(gtbox) #这个框已经匹配到了，不能再匹配
                        break

            fp = 1 - np.array(tp)  # false predict
            tp = np.cumsum(tp)
            fp = np.cumsum(fp)

            recall = tp / num_targets
            precision = tp / np.maximum(tp + fp, np.finfo(np.float64).eps)

            # print(recall[-5:], precision[-5:])
            ap = voc_ap(recall, precision, use_07_metric)
            aps[cls_name] = ap
            print('---class {} ap {}'.format(cls_name, aps[cls_name]))

        print('---map {}---\n'.format(np.mean(aps.values())))
        return aps

    @staticmethod
    def load_labels(file_, dtype='yolo'):
        def load_yolo_labels(file_):
            """load bbox and labels from *.txt annotation file"""
            with open(txt, 'r') as f:
                data = [l.strip().split() for l in f.readlines()]

            fs, anns = [], []
            for ann in data:  # [imgfile, x1, y1, x2, y2, cls, x1, y1, x2, ...]
                if ann:
                    imgfile = ann[0]
                    fs.append(imgfile)
                    for box in np.int32(ann[1:]).reshape(-1, 5):
                        cls = box[-1]  # box: (x1, y1, x2, y2, cls)
                        anns.append([imgfile] + box.tolist())

            from data.classes import VOC_CLASSES
            return fs, anns, VOC_CLASSES

        def load_coco_labels(file_):
            data = json.load(open(file_, 'r'))
            id2file = {d['id']: d['file_name'] for d in data['images']}
            anns = []
            for ann in data['annotations']:
                f = id2file[ann['image_id']]
                b = np.int32(ann['bbox'])
                b[2:] += b[:2]
                c = ann['category_id'] - 1
                anns.append([f] + b.tolist() + [c])

            classes = {c['id']-1: c['name'] for c in data['categories']}
            return list(id2file.values()), anns, [classes[i] for i in range(len(classes))]

        if dtype == 'yolo':
            return load_yolo_labels(file_)
        elif dtype == 'coco':
            return load_coco_labels(file_)

