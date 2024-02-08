SOURCE="datasets/images/For_training/images/isp/human/"
WEIGHTS="runs/train/yolov5n_WM009_DM033_pretrain_96x1_b64_ISP_mix_0803_data_config_2023-08-07_5000epc_NC1_no_mosaic/weights/best-int8.tflite"
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


