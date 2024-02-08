D="data/crop_coco_0707/R1_data_config.yaml"
D="data/HUMAN_DET_1_002_001/data_config.yaml"
WEIGHTS="runs/train/yolov5n_WM009_DM033_pretrain_96x1_b64_ISP_mix_0803_data_config_2023-08-07_5000epc_NC1_no_mosaic/weights/best.pt"
Channel=1
I=96

T=$(date +%Y-%m-%d)
IFS='/' read -r -a dtArray <<< "$D"
IFS='/' read -r -a modelFile <<< "$C"
#IFS='.' read -r -a modelName <<< "${WEIGHTS[-1]}"

python export.py --device 0\
	--data "${D}"\
	--weights "${WEIGHTS}" \
	--imgsz $I --imgch $Channel \
	--iou-thres 0.5 \
	--conf-thres 0.5 \
	--include tflite \
	--int8
