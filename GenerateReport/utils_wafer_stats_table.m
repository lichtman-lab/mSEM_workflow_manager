function waferstr = utils_wafer_stats_table(wafer_info)
    nl = [char(13),newline];
    idt1 = char(9); idt2 = [char(9), char(9)];

    trs = cell(18,1);
    if wafer_info.long_intvl > 0
        trs{1} = [idt1,'<tr>',nl,...
            idt2, '<th>Microscope time (excluding long intervals):</th>',nl,...
            idt2, '<td>',num2str(wafer_info.EM_time/3600,'%.2f'),' hr</td>',nl,...
            idt2, '<td colspan="2"><b>Long interval (&ge;48hr) time:</b></td>',nl,...
            idt2, '<td>',num2str(wafer_info.long_intvl/3600,'%.2f'),' hr</td>',nl,...
            idt1, '</tr>',nl];
    else
        trs{1} = [idt1,'<tr>',nl,...
            idt2, '<th>Microscope time:</th>',nl,...
            idt2, '<td>',num2str(wafer_info.EM_time/3600,'%.2f'),' hr</td>',nl,...
            idt1,'</tr>',nl];
    end

    trs{2} = [idt1,'<tr>',nl,...
        idt2,'<th>Number of batchs:</th>',nl,...
        idt2,'<td>',num2str(wafer_info.batch_num,'%d'),'</td>',nl,...
        idt1,'</tr>'];

    trs{3} = [idt1,'<tr>',nl,...
        idt2, '<th>EM Running time (compared to microscope time):</th>',nl,...
        idt2, '<td>',num2str(wafer_info.run_time/3600,'%.2f'),' hr',...
        local_percent_span_tag(wafer_info.run_time/wafer_info.EM_time),'</td>',nl,...
        idt1,'</tr>',nl];

    tmpstr = [num2str(wafer_info.short_intvl/3600,'%.2f'),' hr',...
        local_grey_span_tag(['avg. ',num2str(wafer_info.short_intvl_avg/3600,'%.2f'),' hr/intvl'])];
    if wafer_info.long_intvl > 0
        trs{4} = [idt1,'<tr>',nl,...
            idt2, '<th>Short interval (<48hr) time:</th>',nl,...
            idt2, '<td>',tmpstr,'</td>',nl,...
            idt1, '</tr>',nl];
    else
        trs{4} = [idt1,'<tr>',nl,...
            idt2, '<th>Interval time (time in between batches):</th>',nl,...
            idt2, '<td>',tmpstr,'</td>',nl,...
            idt1, '</tr>',nl];
    end

    trs{5} = [idt1,'<tr>',nl,...
        idt2,'<th>Total number of ROIs:</th>',nl,...
        idt2,'<td>',num2str(wafer_info.total_ROI,'%d'),'</td>',nl,...
        idt1,'</tr>'];

    trs{6} = [idt1,'<tr>',nl,...
            idt2, '<th>Kept ROIs (compared to the entirety/microscope time):</th>',nl,...
            idt2, '<td>',num2str(wafer_info.kept_ROI,'%d'),...
            local_percent_span_tag(wafer_info.kept_ROI/wafer_info.total_ROI),'</td>',nl,...
            idt2, '<td>storage: ',num2str(wafer_info.kept_ROI_storage/1024,'%.3f'),' TB',...
            local_percent_span_tag(wafer_info.kept_ROI_storage/wafer_info.storage),'</td>',nl,...
            idt2, '<td>time: ',num2str(wafer_info.kept_ROI_time/3600,'%.2f'),' hr',...
            local_percent_span_tag(wafer_info.kept_ROI_time/wafer_info.EM_time),'</td>',nl,...
            idt1, '</tr>',nl];
        
    trs{7} = [idt1,'<tr>',nl,...
            idt2, '<th>Retakes (compared to the kept ROIs):</th>',nl,...
            idt2, '<td>', num2str(wafer_info.retake,'%d'),...
            local_percent_span_tag(wafer_info.retake/wafer_info.kept_ROI),'</td>',nl,...
            idt2, '<td>storage: ',num2str(wafer_info.retake_storage/1024,'%.3f'),' TB',...
            local_percent_span_tag(wafer_info.retake_storage/wafer_info.kept_ROI_storage),'</td>',nl,...
            idt2, '<td>time: ',num2str(wafer_info.retake_time/3600,'%.2f'), ' hr',...
            local_percent_span_tag(wafer_info.retake_time/wafer_info.kept_ROI_time),'</td>',nl,...
            idt1, '</tr>',nl];

    trs{8} = [idt1,'<tr>',nl,...
            idt2,'<th>Total storage:</th>',nl,...
            idt2,'<td>',num2str(wafer_info.storage/1024,'%.3f'),' TB</td>',nl,...
            idt1,'</tr>'];

    trs{9} = [idt1,'<tr title="entire dataset/microscope time">',nl,...
            idt2,'<th>Data rate (including retakes):</th>',nl,...
            idt2,'<td>',num2str(wafer_info.storage/1024/wafer_info.EM_time*3600,'%.3f'),' TB/hr</td>',nl,...
            idt1,'</tr>'];

    trs{10} = [idt1,'<tr title="kept version/microscope time">',nl,...
            idt2,'<th>Valid data rate (excluding retakes):</th>',nl,...
            idt2,'<td>',num2str(wafer_info.kept_ROI_storage/1024/wafer_info.EM_time*3600,'%.3f'), ' TB/hr</td>',nl,...
            idt1,'</tr>'];

    trs{11} = [idt1,'<tr><th>----------------------------------------------------------</th></tr>',nl];

    trs{12} = [idt1,'<tr>',nl,...
        idt2,'<th>AFAS failure ROIs:</th>',nl,...
        idt2,'<td>',num2str(wafer_info.AFAS,'%d'),...
        local_percent_span_tag(wafer_info.AFAS/wafer_info.total_ROI,'%.3f'),'</td>',nl,...
        idt2, '<td title="compared to the entire dataset">storage: ',num2str(wafer_info.AFAS_storage/1024,'%.3f'),' TB',...
        local_percent_span_tag(wafer_info.AFAS_storage/wafer_info.storage),'</td>',nl,...
        idt2, '<td title="compared to EM running time">time: ',num2str(wafer_info.AFAS_time/3600,'%.2f'),' hr',...
        local_percent_span_tag(wafer_info.AFAS_time/wafer_info.run_time),'</td>',nl,...
        idt1,'</tr>'];

    trs{13} = [idt1,'<tr>',nl,...
        idt2,'<th>Soft focus/Bad stig/B2F error ROIs:</th>',nl,...
        idt2,'<td>',num2str(wafer_info.bad_focus,'%d'),...
        local_percent_span_tag(wafer_info.bad_focus/wafer_info.total_ROI,'%.3f'),'</td>',nl,...
        idt2, '<td title="compared to the entire dataset">storage: ',num2str(wafer_info.bad_focus_storage/1024,'%.3f'),' TB',...
        local_percent_span_tag(wafer_info.bad_focus_storage/wafer_info.storage),'</td>',nl,...
        idt2, '<td title="compared to EM running time">time: ',num2str(wafer_info.bad_focus_time/3600,'%.2f'),' hr',...
        local_percent_span_tag(wafer_info.bad_focus_time/wafer_info.run_time),'</td>',nl,...
        idt1,'</tr>'];
    
    trs{14} = [idt1,'<tr>',nl,...
        idt2,'<th>Off-target ROIs:</th>',nl,...
        idt2,'<td>',num2str(wafer_info.off_target,'%d'),...
        local_percent_span_tag(wafer_info.off_target/wafer_info.total_ROI,'%.3f'),'</td>',nl,...
        idt2, '<td title="compared to the entire dataset">storage: ',num2str(wafer_info.off_target_storage/1024,'%.3f'),' TB',...
        local_percent_span_tag(wafer_info.off_target_storage/wafer_info.storage),'</td>',nl,...
        idt2, '<td title="compared to EM running time">time: ',num2str(wafer_info.off_target_time/3600,'%.2f'),' hr',...
        local_percent_span_tag(wafer_info.off_target_time/wafer_info.run_time),'</td>',nl,...
        idt1,'</tr>'];
    
    trs{15} = [idt1,'<tr>',nl,...
        idt2,'<th>Patial/Broken/Coming-in ROIs:</th>',nl,...
        idt2,'<td>',num2str(wafer_info.partial_section,'%d'),...
        local_percent_span_tag(wafer_info.partial_section/wafer_info.kept_ROI,'%.3f'),'</td>',nl,...
        idt1,'</tr>'];
    
    trs{16} = [idt1,'<tr>',nl,...
        idt2,'<th>Jitter rate:</th>',nl,...
        idt2,'<td>',num2str(wafer_info.jitter_rate*100,'%.3f'),...
        local_grey_span_tag('per 100 mFoVs'),'</td>',nl,...
        idt1,'</tr>'];

    trs{17} = [idt1,'<tr>',nl,...
        idt2,'<th>Skew rate:</th>',nl,...
        idt2,'<td>',num2str(wafer_info.skew_rate*100,'%.3f'),...
        local_grey_span_tag('per 100 mFoVs'),'</td>',nl,...
        idt1,'</tr>'];

    trs{18} = [idt1,'<tr>',nl,...
        idt2,'<th>Scanfault rate:</th>',nl,...
        idt2,'<td>',num2str(wafer_info.scanfault_rate*100,'%.3f'),...
        local_grey_span_tag('per 100 mFoVs'),'</td>',nl,...
        idt1,'</tr>'];

    waferstr = ['<table id="waferStats">',nl, horzcat(trs{:}),'</table>',nl,'<br>',nl];
end


function p_str = local_grey_span_tag(str1)
    p_str = ['<span style="color:dimgray;"> (',str1,')</span>'];
end

function p_str = local_percent_span_tag(p,fmtstr)
    if nargin < 2
        fmtstr = '%.1f';
    end
    p_str = ['<span style="color:dimgray;"> (',...
        num2str(p*100,fmtstr),'%) </span>'];
end