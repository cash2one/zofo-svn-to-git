package org.pssframework.controller.statistics;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jxls.exception.ParsePropertyException;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.pssframework.controller.BaseSpringController;
import org.pssframework.model.system.OrgInfo;
import org.pssframework.query.statistics.StatisticsQuery;
import org.pssframework.report.Excel;
import org.pssframework.report.model.ExcelModel;
import org.pssframework.service.statistics.StatisticsManager;
import org.pssframework.service.statistics.StatisticsType;
import org.pssframework.service.system.OrgInfoManager;
import org.pssframework.util.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.org.rapid_framework.page.Page;
import cn.org.rapid_framework.page.PageRequest;

import com.google.common.collect.Maps;

/**
 * 
 * @author Nick
 * 
 */
@Controller
@RequestMapping("/statistics/gdkkxQuery")
public class GdkkxQueryController extends BaseSpringController {
    private static final String VIEW_NAME = "/statistics/gdkkxQuery";
    private static final String VIEW_NAME_IFRAME = "/statistics/gdkkxDataQuery";
    private static final String SDATE = "sdate";
    private static final String EDATE = "edate";
    private static final String ORGLIST = "orglist";

    @Autowired
    private OrgInfoManager orgInfoManager;

    @Autowired
    private StatisticsManager statisticsManager;

    // 默认多列排序,example: username desc,createTime asc
    protected static final String DEFAULT_SORT_COLUMNS = "ddate desc";

    /**
     * 
     * @param mav
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping
    public ModelAndView index(ModelAndView mav, HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        mav.setViewName(VIEW_NAME);
        initPageParams(mav);
        return mav;
    }

    /**
     * 
     * @param modelAndView
     * @param request
     * @param response
     * @param statisticsQuery
     * @return
     */
    @SuppressWarnings("unchecked")
    @RequestMapping(value = "/gdkkxData")
    public ModelAndView _gdkkx(ModelAndView mav, HttpServletRequest request, HttpServletResponse response,
            StatisticsQuery sq) throws Exception {
        PageRequest<Map> pageRequest = bindPageRequest(request, sq, DEFAULT_SORT_COLUMNS);
        Page page = this.statisticsManager.findByPageRequest(pageRequest, StatisticsType.GdkkxData);// 获取数据模型

        page.setExportReport("/statistics/gdkkxQuery/excel");
        mav.addObject("page", page);
        mav.addObject("pageRequest", pageRequest);
        mav.setViewName(VIEW_NAME_IFRAME);
        return mav;
    }

    @SuppressWarnings("unchecked")
    @RequestMapping("/excel")
    public void excel(ModelAndView mav, HttpServletRequest request, HttpServletResponse response,
            StatisticsQuery statisticsQuery) {
        PageRequest<Map> pageRequest = bindPageRequest(request, statisticsQuery, DEFAULT_SORT_COLUMNS);

        pageRequest.setPageSize(Integer.MAX_VALUE);
        Page page = this.statisticsManager.findByPageRequest(pageRequest, StatisticsType.GdkkxData);// 获取数据模型

        Map dataMap = Maps.newHashMap();
        dataMap.put("item", page.getResult());
        dataMap.put("dateFormat", new SimpleDateFormat("yyyy-MM-dd"));

        Excel excel;
        ExcelModel excelModel;
        excelModel = new ExcelModel(VIEW_NAME_IFRAME);
        excelModel.setTitle("供电可靠性");
        excelModel.setDataMap(dataMap);
        excel = new Excel(excelModel);

        try {
            excel.exportData(request, response);
        }
        catch(ParsePropertyException e) {
            logger.error(e.getMessage());
        }
        catch(InvalidFormatException e) {
            logger.error(e.getMessage());
        }
        catch(IOException e) {
            logger.error(e.getMessage());
        }
    }

    /**
     * 初始化页面参数
     * 
     * @param mav
     */
    @SuppressWarnings("unchecked")
    private void initPageParams(ModelAndView mav) {
        Map mapRequest = new LinkedHashMap();
        mav.addObject(ORGLIST, this.getOrgOptions(mapRequest));
        mav.addObject(SDATE, DateUtils.getCurrentDate());
        mav.addObject(EDATE, DateUtils.getCurrentDate());
    }

    private List<OrgInfo> getOrgOptions(Map<String, ?> mapRequest) {
        return this.orgInfoManager.findByPageRequest(mapRequest);
    }
}
