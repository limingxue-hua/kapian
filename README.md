KPI页面访问次数 = 
/* ========= 1️⃣ 基础 ========= */
VAR _title = "页面访问次数"
VAR _value = [tab页面访问次数]
VAR _valueText = FORMAT(_value,  "¥#,##0")
/* ========= 2️⃣ 趋势 ========= */
VAR _yoy = [tab页面访问次数同比]
VAR _mom = [tab页面访问次数月环比]
VAR _wow = [tab页面访问次数周环比]
VAR _yoyText = FORMAT(_yoy, "0.0%")
VAR _momText = FORMAT(_mom, "0.0%")
VAR _wowText = FORMAT(_wow, "0.0%")
VAR _yoyUp = _yoy >= 0
VAR _momUp = _mom >= 0
VAR _wowUp = _wow >= 0
VAR _yoyCls = IF(_yoyUp, "up", "down")
VAR _momCls = IF(_momUp, "up", "down")
VAR _wowCls = IF(_wowUp, "up", "down")
VAR _yoyArrow = IF(_yoyUp, "▲", "▼")
VAR _momArrow = IF(_momUp, "▲", "▼")
VAR _wowArrow = IF(_wowUp, "▲", "▼")
/* ========= 3️⃣ 强弱（15% 封顶） ========= */
VAR _cap = 0.15
VAR _yoyWidth = FORMAT( MIN( ABS(_yoy), _cap ) / _cap, "0%" )
VAR _momWidth = FORMAT( MIN( ABS(_mom), _cap ) / _cap, "0%" )
VAR _wowWidth = FORMAT( MIN( ABS(_wow), _cap ) / _cap, "0%" )
/* ========= 4️⃣ 样式 ========= */
VAR _style =
"<style>
:root{
  --r:18px;
  --glass:rgba(255,255,255,.22);
  --stroke:rgba(255,255,255,.30);
  --shadow:0 18px 45px rgba(0,0,0,.18);
  --muted:rgba(16,18,22,.55);
  --up:#1a7f37;
  --down:#d1242f;
}
.kpi_wrap{
  width:100%;height:100%;
  display:flex;justify-content:center;align-items:center;
  font-family:system-ui,-apple-system,Segoe UI,Arial;
  border-radius:16px;overflow:hidden;
  background:
    radial-gradient(420px 320px at 20% 30%, rgba(236,226,254,.9), transparent 60%),
    radial-gradient(420px 320px at 80% 70%, rgba(217,243,253,.9), transparent 60%),
    linear-gradient(135deg,#ece2fe,#d9f3fd);
  padding:8px;box-sizing:border-box;
}
.kpi_card{
  width:min(420px,100%);
  border-radius:var(--r);
  background:var(--glass);
  border:1px solid var(--stroke);
  box-shadow:var(--shadow);
  backdrop-filter:blur(22px) saturate(140%);
}
.kpi_bar{
  height:14px;
  background:linear-gradient(to right,#bcaaff,#dee3f6,#d4e7f8);
}
.kpi_body{
  padding:10px 14px;
  display:flex;
  justify-content:space-between;
  align-items:flex-start;
  gap:14px;
}
.kpi_left{flex:1;}
.kpi_title{
  font-size:22px;
  font-weight:800;
  letter-spacing:.06em;
  color:var(--muted);
}
.kpi_value{
  margin-top:10px;
  font-size:36px;
  font-weight:950;
  color:#555;
}
/* ===== 右侧趋势 ===== */
.kpi_trends{
  min-width:150px;
  display:flex;
  flex-direction:column;
  gap:8px;
}
.kpi_trend_pill{
  display:flex;
  align-items:center;
  gap:8px;
  padding:6px 10px;
  border-radius:999px;
  background:rgba(255,255,255,.22);
  border:1px solid rgba(255,255,255,.32);
  backdrop-filter:blur(12px);
  font-size:14px;
  font-weight:800;
}
/* 🔥 标签：变大 + 跟随趋势颜色 */
.kpi_trend_label{
  width:44px;
  text-align:right;
  font-size:14px;
  font-weight:900;
}
/* 数值（无背景） */
.kpi_trend_value{
  white-space:nowrap;
  background:none !important;
}
/* 强弱条 */
.kpi_strength{
  flex:1;
  height:6px;
  border-radius:999px;
  background:rgba(0,0,0,.08);
  overflow:hidden;
}
.kpi_strength_fill{
  height:100%;
  border-radius:999px;
}
/* 文本颜色同步 */
.kpi_trend_pill.up .kpi_trend_label,
.kpi_trend_pill.up .kpi_trend_value{
  color:var(--up);
}
.kpi_trend_pill.down .kpi_trend_label,
.kpi_trend_pill.down .kpi_trend_value{
  color:var(--down);
}
/* 强弱条颜色 */
.kpi_trend_pill.up .kpi_strength_fill{
  background:linear-gradient(90deg,#3fb950,#1a7f37);
}
.kpi_trend_pill.down .kpi_strength_fill{
  background:linear-gradient(90deg,#ff7b72,#d1242f);
}
</style>"
/* ========= 5️⃣ HTML ========= */
VAR _html =
"<div class='kpi_wrap'>
  <div class='kpi_card'>
    <div class='kpi_bar'></div>
    <div class='kpi_body'>
      <div class='kpi_left'>
        <div class='kpi_title'>" & _title & "</div>
        <div class='kpi_value'>" & _valueText & "</div>
      </div>
      <div class='kpi_trends'>
        <div class='kpi_trend_pill " & _yoyCls & "'>
          <div class='kpi_trend_label'>同比</div>
          <div class='kpi_trend_value'>" & _yoyArrow & " " & _yoyText & "</div>
          <div class='kpi_strength'><div class='kpi_strength_fill' style='width:" & _yoyWidth & "'></div></div>
        </div>
        <div class='kpi_trend_pill " & _momCls & "'>
          <div class='kpi_trend_label'>月环比</div>
          <div class='kpi_trend_value'>" & _momArrow & " " & _momText & "</div>
          <div class='kpi_strength'><div class='kpi_strength_fill' style='width:" & _momWidth & "'></div></div>
        </div>
        <div class='kpi_trend_pill " & _wowCls & "'>
          <div class='kpi_trend_label'>周环比</div>
          <div class='kpi_trend_value'>" & _wowArrow & " " & _wowText & "</div>
          <div class='kpi_strength'><div class='kpi_strength_fill' style='width:" & _wowWidth & "'></div></div>
        </div>
      </div>
    </div>
  </div>
</div>"
RETURN
_style & _html
