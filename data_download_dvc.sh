cd ..
if [ -d "datasets" ]; then
	echo "datasets exist, move to backup and re-download。"
	mv datasets "datasets_$(date +'%Y-%m-%d_%H-%M-%S')"
else
	echo "datasets create。"
fi

git clone -b human_detect git@fp-Gitlab.fitipower.inc:hcita/auto/data_center.git -l datasets

cd datasets # enter the unique folder
dvc checkout

