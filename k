SVG Visualization总人效 = 
VAR GrowthRate = [总人效同比]  // 替换为您的实际增长率度量值名称
VAR GrowthAmount = [总人效]-[同期总人效1] // 替换为您的实际增长额度量值名称
VAR EmployeeCount = [总人效] // 替换为您的实际员工人数度量值名称
VAR LastYearCount = [同期总人效1] // 去年同期员工人数
VAR PositiveColor = "#008100" // 绿色
VAR NegativeColor = "#F44336" // 红色
VAR FillColor = IF(GrowthRate >= 0, PositiveColor, NegativeColor)
VAR Arrow = IF(GrowthRate >= 0, "▲", "▼")
// 格式化数值
VAR FormattedEmployee = FORMAT(EmployeeCount, "#,##0")
VAR FormattedLastYear = FORMAT(LastYearCount, "#,##0")
VAR FormattedGrowthRate = FORMAT(ABS(GrowthRate), "0.0%")
VAR FormattedGrowthAmount = FORMAT(ABS(GrowthAmount), "#,##0")
// 构建SVG字符串
VAR SVG = 
"<svg xmlns='http://www.w3.org/2000/svg' width='315' height='120' viewBox='0 0 315 120'>
    <!-- 背景矩形 -->
    <rect width='311' height='116' x='2' y='2' rx='8' ry='8' 
          fill='none' stroke='lightgray' stroke-width='2'/>
    <!-- 左侧状态方块 -->
    <rect width='70' height='70' x='15' y='15' rx='8' ry='8'
          fill='" & FillColor & "' fill-opacity='0.3' stroke='none'/>
    <!-- 中央箭头 -->
    <text x='50' y='58' text-anchor='middle' font-size='40'
          fill='" & FillColor & "' font-weight='bold'>" & Arrow & "</text>
    <!-- 当前员工人数（放大显示） -->
    <text x='110' y='40' font-size='14' fill='#666666' font-weight='bold' text-anchor='start'>总人效</text>
    <text x='100' y='65' font-size='20' fill='#424242' font-weight='bold' text-anchor='start'>" & FormattedEmployee & "</text>
    <!-- 右侧去年同期 -->
    <text x='290' y='40' font-size='14' fill='#666666' font-weight='bold' text-anchor='end'>去年同期</text>
    <text x='290' y='65' font-size='16' fill='#666666' font-weight='bold' text-anchor='end'>" & FormattedLastYear & "</text>
   <!-- 底部增长信息（水平并列） -->
    <!-- 同比标签（灰色） -->
    <text x='100' y='100' font-size='14' fill='#666666' text-anchor='start'>同比：</text>
    <!-- 同比数值（带颜色） -->
    <text x='140' y='100' font-size='14' fill='" & FillColor & "' text-anchor='start'>" & 
        IF(GrowthRate >= 0, "+", "-") & FormattedGrowthRate & "</text>
    <!-- 增长标签（灰色） -->
    <text x='220' y='100' font-size='14' fill='#666666' text-anchor='start'>增长：</text>
    <!-- 增长数值（带颜色） -->
    <text x='255' y='100' font-size='14' fill='" & FillColor & "' text-anchor='start'>" & 
        IF(GrowthAmount >= 0, "+", "-") & FormattedGrowthAmount & "</text>
</svg>"
RETURN SVG
