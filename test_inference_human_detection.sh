#SOURCE="/home/lawr/workspace/human_detect_project/datasets/inference_images/cropped_coco/train/all/background/"
#SOURCE="/home/lawr/workspace/human_detect_project/datasets/inference_images/cropped_coco/train/all/human/"
#SOURCE="/home/lawr/workspace/human_detect_project/datasets/inference_images/coco/for_pretrain/background/"
#SOURCE="/home/lawr/workspace/human_detect_project/datasets/inference_images/coco/for_pretrain/human/"
#SOURCE="/home/lawr/workspace/human_detect_project/datasets/inference_images/cropped_cctv/human/"
#SOURCE="/home/lawr/workspace/human_detect_project/datasets/inference_images/96x96ROI_Data/human/"
#SOURCE="/home/lawr/workspace/human_detect_project/datasets/inference_images/people_counting/coco/human/"
#SOURCE="/home/lawr/workspace/human_detect_project/datasets/inference_images/people_counting/coco/background/"
SOURCE="datasets/images/inference_images/background/"
WEIGHTS="runs/train/yolov5n_WM01_std_96x1_b64_mix_for_pretrain_0707_data_config_2023-07-07_1000epc2/2023-07-07_15-58/avg/yolov5_667_p-0.8653_r-0.865_map50-0.6556-int8.tflite" # int8 tflite model
#WEIGHTS="/home/lawr/workspace/human_detect_project/yolov5/runs/train/yolov5n_WM01_pretrain_96x1_b64_crop_coco_0707_R3_data_config_2023-07-18_50epc/weights/best-int8.tflite" # int8 tflite model
#WEIGHTS="/home/lawr/workspace/human_detect_project/yolov5/runs/train/yolov5n_WM009_DM033_std_96x1_b64_coco200_pplcnt_0722_data_config_2023-07-21_3000epc/2023-07-21_13-28/avg/yolov5_2844_p-0.8396_r-0.7453_map50-0.3804-int8.tflite"

Channel=1
I=96

T=$(date +%Y-%m-%d)
IFS='/' read -r -a dtArray <<< "$SOURCE"
IFS='/' read -r -a modelFile <<< "$C"
#IFS='.' read -r -a modelName <<< "${modelFile[-1]}"

if [[ "${SOURCE}" == */human/ ]]; then
    cls=0
elif [[ "${SOURCE}" == */background/ ]]; then
    cls=1
else
    cls=99
fi

python tflite_int8_infer_conf_human_detect_excel.py -d 1 \
	-s "${SOURCE}"\
	-w "${WEIGHTS}" \
	--img-size $I --img_ch $Channel \
	--conf_thres 0.4 \
	--store_image_result \
	--show_cls_conf \
	--cls $cls \


