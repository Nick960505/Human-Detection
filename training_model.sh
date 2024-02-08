D="data/HUMAN_DET_1_002_001/data_config.yaml"
C="models/yolov5n_WM009_DM033.yaml"
H="lh_hyp_scratch_tiny_non_mosaic.yaml"
# for transfer learning
WEIGHTS="runs/train/yolov5n_WM009_DM033_pretrain_96x1_b64_ISP_mix_0803_data_config_2023-08-03_1000epc4/weights/best.pt"
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

