D="data/coco_mix_cctv_0810/data_config_general.yaml"
C="models/yolov5n_WM009_DM033.yaml"
H="lh_hyp_scratch_tiny_non_mosaic.yaml"
# for transfer learning
#WEIGHTS="runs/train/yolov5n_WM009_DM033_pretrain_96x1_b64_crop_coco_0707_R3_data_config_2023-07-19_1000epc/2023-07-19_17-52/avg/yolov5_263_p-0.9011_r-0.9_map50-0.823.pt"
Channel=1
I=96
B=64
E=5000
T=$(date +%Y-%m-%d)
IFS='/' read -r -a dtArray <<< "$D"
IFS='/' read -r -a modelFile <<< "$C"
IFS='.' read -r -a modelName <<< "${modelFile[-1]}"
IFS='.' read -r -a DataName <<< "${dtArray[-1]}"

if [ -z "$WEIGHTS" ]; then
    w="std"
else
    w="pretrain"
fi

python train.py --workers 8 --device 0\
	--data "${D}"\
	--weights "${WEIGHTS}" \
	--hyp data/hyps/"${H}" \
	--name ${modelName[0]}_${w}_${I}x${Channel}_b${B}_${dtArray[-2]}_${DataName[0]}_${T}_${E}epc\
	--batch-size $B \
	--cfg "${C}" \
	--img-size $I --img-ch $Channel \
	--epochs $E \
	--patience 5000
	# --freeze 10 # for transfer learning

