pkill mk_manager
pkill minknow
sleep 5
pkill dorado
sleep 5

dorado_basecall_server -x cuda:all -c /opt/ont/dorado/data/dna_r10.4.1_e8.2_400bps_5khz_hac.cfg -p ipc:///tmp/.guppy/5555 -l minknow_run/logs/dorado --verbose_logs &
sleep 5 && echo "Initiated basecall server"
/opt/ont/minknow/bin/mk_manager_svc -c /opt/ont/minknow/conf --simulated-integrated-devices=1 -d &
sleep 10 && echo "Initiated minknow server"
bash /opt/ont/minknow/bin/add_simulated_prom.sh
sleep 40 && echo "Added simulated promethion device!"

python3 /simION/code/start_protocol_mod_prom.py --experiment-duration 2 --position 1A --kit SQK-LSK114 --pod5 --fastq --basecalling --fastq-reads-per-file 1000 --pod5-reads-per-file 1000

sleep 2
python3 /simION/code/query_minknow_run.py
python3 /simION/code/read_length_hist.py

