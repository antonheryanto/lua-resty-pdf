-- Copyright 2015 @ Anton Heryanto
-- based on extensive work by https://github.com/tavikukko/lua-resty-hpdf/
local ffi = require 'ffi'
local ffi_cdef = ffi.cdef
local ffi_new = ffi.new
local C = ffi.load('libhpdf')

ffi_cdef[[
typedef void *HPDF_HANDLE;
typedef HPDF_HANDLE HPDF_Doc;
typedef HPDF_HANDLE HPDF_Page;
typedef HPDF_HANDLE HPDF_Pages;
typedef HPDF_HANDLE HPDF_Stream;
typedef HPDF_HANDLE HPDF_Image;
typedef HPDF_HANDLE HPDF_Font;
typedef HPDF_HANDLE HPDF_Outline;
typedef HPDF_HANDLE HPDF_Encoder;
typedef HPDF_HANDLE HPDF_3DMeasure;
typedef HPDF_HANDLE HPDF_ExData;
typedef HPDF_HANDLE HPDF_Destination;
typedef HPDF_HANDLE HPDF_XObject;
typedef HPDF_HANDLE HPDF_Annotation;
typedef HPDF_HANDLE HPDF_ExtGState;
typedef HPDF_HANDLE HPDF_FontDef;
typedef HPDF_HANDLE HPDF_U3D;
typedef HPDF_HANDLE HPDF_JavaScript;
typedef HPDF_HANDLE HPDF_Error;
typedef HPDF_HANDLE HPDF_MMgr;
typedef HPDF_HANDLE HPDF_Dict;
typedef HPDF_HANDLE HPDF_EmbeddedFile;
typedef HPDF_HANDLE HPDF_OutputIntent;
typedef HPDF_HANDLE HPDF_Xref;
typedef signed int HPDF_INT;
typedef unsigned int HPDF_UINT;
typedef unsigned long HPDF_STATUS;
typedef  struct  _HPDF_Date {
    HPDF_INT    year;
    HPDF_INT    month;
    HPDF_INT    day;
    HPDF_INT    hour;
    HPDF_INT    minutes;
    HPDF_INT    seconds;
    char        ind;
    HPDF_INT    off_hour;
    HPDF_INT    off_minutes;
} HPDF_Date;
typedef enum _HPDF_InfoType {
    /* date-time type parameters */
    HPDF_INFO_CREATION_DATE = 0,
    HPDF_INFO_MOD_DATE,
    /* string type parameters */
    HPDF_INFO_AUTHOR,
    HPDF_INFO_CREATOR,
    HPDF_INFO_PRODUCER,
    HPDF_INFO_TITLE,
    HPDF_INFO_SUBJECT,
    HPDF_INFO_KEYWORDS,
    HPDF_INFO_TRAPPED,
    HPDF_INFO_GTS_PDFX,
    HPDF_INFO_EOF
} HPDF_InfoType;
typedef enum _HPDF_TextAlignment {
    HPDF_TALIGN_LEFT = 0,
    HPDF_TALIGN_RIGHT,
    HPDF_TALIGN_CENTER,
    HPDF_TALIGN_JUSTIFY} HPDF_TextAlignment;
typedef enum _HPDF_PageSizes {
    HPDF_PAGE_SIZE_LETTER = 0,
    HPDF_PAGE_SIZE_LEGAL,
    HPDF_PAGE_SIZE_A3,
    HPDF_PAGE_SIZE_A4,
    HPDF_PAGE_SIZE_A5,
    HPDF_PAGE_SIZE_B4,
    HPDF_PAGE_SIZE_B5,
    HPDF_PAGE_SIZE_EXECUTIVE,
    HPDF_PAGE_SIZE_US4x6,
    HPDF_PAGE_SIZE_US4x8,
    HPDF_PAGE_SIZE_US5x7,
    HPDF_PAGE_SIZE_COMM10,
    HPDF_PAGE_SIZE_EOF
} HPDF_PageSizes;
typedef enum _HPDF_PageDirection {
        HPDF_PAGE_PORTRAIT = 0,
        HPDF_PAGE_LANDSCAPE
} HPDF_PageDirection;
typedef enum _HPDF_PageNumStyle {
    HPDF_PAGE_NUM_STYLE_DECIMAL = 0,
    HPDF_PAGE_NUM_STYLE_UPPER_ROMAN,
    HPDF_PAGE_NUM_STYLE_LOWER_ROMAN,
    HPDF_PAGE_NUM_STYLE_UPPER_LETTERS,
    HPDF_PAGE_NUM_STYLE_LOWER_LETTERS,
    HPDF_PAGE_NUM_STYLE_EOF
} HPDF_PageNumStyle;
typedef signed int HPDF_BOOL;
typedef float HPDF_REAL;
const char * HPDF_GetVersion();
typedef void (*HPDF_Error_Handler) (unsigned long error_no, 
    unsigned long detail_no, void  *user_data);
void * HPDF_New(HPDF_Error_Handler user_error_fn, void *user_data);
void * HPDF_SetInfoAttr(HPDF_Doc pdf, HPDF_InfoType type, const char  *value);
void * HPDF_SetInfoDateAttr(HPDF_Doc pdf, HPDF_InfoType type, HPDF_Date value);
void * HPDF_SetCompressionMode(HPDF_Doc pdf, HPDF_UINT mode);
void * HPDF_AddPage(HPDF_Doc pdf);
float HPDF_Page_GetHeight(HPDF_Page page);
float HPDF_Page_GetWidth(HPDF_Page page);
float HPDF_Page_GetTextLeading(HPDF_Page page);
void * HPDF_GetFont(HPDF_Doc pdf, const char *font_name, 
    const char *encoding_name);
void * HPDF_Page_SetFontAndSize(HPDF_Page page,HPDF_Font font, HPDF_REAL size);
void * HPDF_Page_BeginText(HPDF_Page page);
void * HPDF_Page_TextOut(HPDF_Page page, HPDF_REAL xpos, HPDF_REAL ypos,
    const char *text);
void * HPDF_Page_EndText(HPDF_Page page);
void * HPDF_Free(HPDF_Doc pdf);
void * HPDF_SetCurrentEncoder(HPDF_Doc pdf, const char *encoding_name);
void * HPDF_UseUTFEncodings(HPDF_Doc pdf);
void * HPDF_UseJPEncodings(HPDF_Doc pdf);
void * HPDF_UseKREncodings(HPDF_Doc pdf);
void * HPDF_UseCNSEncodings(HPDF_Doc pdf);
void * HPDF_UseCNTEncodings(HPDF_Doc pdf);
void * HPDF_GetEncoder(HPDF_Doc pdf, const char *encoding_name);
void * HPDF_SetCurrentEncoder(HPDF_Doc pdf, const char *encoding_name);
void * HPDF_GetCurrentEncoder(HPDF_Doc pdf);
const char* HPDF_LoadTTFontFromFile(HPDF_Doc pdf, const char *file_name,
    HPDF_BOOL embedding);
const char* HPDF_LoadType1FontFromFile(HPDF_Doc pdf, const char *afm_file_name,
    const char *data_file_name);
const char* HPDF_LoadTTFontFromFile2(HPDF_Doc pdf, const char *file_name,
    HPDF_UINT index, HPDF_BOOL embedding);
void * HPDF_Page_TextRect(HPDF_Page page, HPDF_REAL left, HPDF_REAL top,
    HPDF_REAL right, HPDF_REAL bottom, const char *text,
    HPDF_TextAlignment align, HPDF_UINT *len);
HPDF_REAL HPDF_Page_TextWidth(HPDF_Page page, const char *text);
void * HPDF_Page_SetSize(HPDF_Page page, HPDF_PageSizes size,
    HPDF_PageDirection direction);
void * HPDF_Page_SetTextLeading(HPDF_Page page, HPDF_REAL value);
void * HPDF_Page_Rectangle(HPDF_Page page, HPDF_REAL x, HPDF_REAL y,
    HPDF_REAL width, HPDF_REAL height);
void * HPDF_Page_Stroke(HPDF_Page page);
void * HPDF_Page_SetRGBFill(HPDF_Page page, HPDF_REAL r, HPDF_REAL g, 
    HPDF_REAL b);
void * HPDF_Page_Fill(HPDF_Page page);
void * HPDF_Page_GSave(HPDF_Page page);
void * HPDF_Page_GRestore(HPDF_Page page);
void * HPDF_Page_GetLineWidth(HPDF_Page page);
void * HPDF_Page_MoveTextPos(HPDF_Page page, HPDF_REAL x, HPDF_REAL y);
void * HPDF_Page_MoveTo(HPDF_Page page, HPDF_REAL x, HPDF_REAL y);
void * HPDF_Page_LineTo(HPDF_Page page, HPDF_REAL x, HPDF_REAL y);
void * HPDF_Page_SetLineWidth(HPDF_Page page, HPDF_REAL line_width);
void * HPDF_Page_SetGrayFill(HPDF_Page page, HPDF_REAL gray);
void * HPDF_Page_SetGrayStroke(HPDF_Page page, HPDF_REAL gray);
void * HPDF_Page_Circle(HPDF_Page page, HPDF_REAL x, HPDF_REAL y,
    HPDF_REAL ray);
void * HPDF_Page_Concat(HPDF_Page page,HPDF_REAL a, HPDF_REAL b, HPDF_REAL c,
    HPDF_REAL d, HPDF_REAL x, HPDF_REAL y);
void * HPDF_Page_ShowText(HPDF_Page page,const char *text);
void * HPDF_Page_SetTextMatrix(HPDF_Page page, HPDF_REAL a, HPDF_REAL b,
    HPDF_REAL c, HPDF_REAL d, HPDF_REAL x, HPDF_REAL y);
void * HPDF_AddPageLabel(HPDF_Doc pdf, HPDF_UINT page_num,
HPDF_PageNumStyle style, HPDF_UINT first_page, const char *prefix);
void * HPDF_SaveToFile(HPDF_Doc pdf, const char *file_name);
void * HPDF_LoadPngImageFromFile(HPDF_Doc pdf, const char  *filename);
void * HPDF_LoadJpegImageFromFile(HPDF_Doc pdf, const char  *filename);
void * HPDF_Page_DrawImage (HPDF_Page page, HPDF_Image image, HPDF_REAL x,
    HPDF_REAL y, HPDF_REAL width, HPDF_REAL height);
HPDF_UINT HPDF_Image_GetWidth(HPDF_Image image);
HPDF_UINT HPDF_Image_GetHeight(HPDF_Image image);
HPDF_UINT HPDF_Page_MeasureText(HPDF_Page page, const char *text,
    HPDF_REAL width, HPDF_BOOL wordwrap, HPDF_REAL *real_width);
HPDF_UINT HPDF_Font_GetCapHeight(HPDF_Font font);
]]

local setmetatable = setmetatable
local format = string.format
local byte = string.byte
local sub = string.sub
local tonumber = tonumber
local pcall = pcall
local ceil = math.ceil
local log = ngx.log
local WARN = ngx.WARN
local utctime = ngx.utctime

local ok, new_tab = pcall(require, "table.new")
if not ok then
    new_tab = function (narr, nrec) return {} end
end

local function err(error_no, detail_no, user_data)
    log(WARN, format('libharu error no: %04X, detail no: %d', tonumber(error_no), tonumber(detail_no)))
end

local _M = new_tab(0, 10)
local mt = { __index = _M }

_M.VERSION = '0.1.0'

local function get_date(year, month, day, hour, minute, second, 
    ind, off_hour, off_minute)
    local date = ffi_new('HPDF_Date')
    date.year = year
    date.month = month
    date.day = day
    date.hour = hour or 0
    date.minutes = minute or 0
    date.seconds = second or 0
    date.ind = byte(ind or ' ')
    date.off_hour = off_hour or 0
    date.off_minutes = off_minute or 0
    return date
end 

local function parse_date()
    local date = utctime()
    return get_date(tonumber(sub(date, 1, 4)), tonumber(sub(date, 6, 7)),
    tonumber(sub(date, 9, 10)), tonumber(sub(date, 12, 13)),
    tonumber(sub(date, 15, 16)), tonumber(sub(date, 18,19)))
end

function _M.new(self, err_fn)
    local doc = C.HPDF_New(err, nil)
    if not doc then
        return nil, 'initialization failed'
    end
    local page = C.HPDF_AddPage(doc)
    local font = C.HPDF_GetFont(doc, "Times-Roman", nil)
    local font_size = 12
    local date = parse_date()
    local line_space = 1.7

    C.HPDF_SetInfoDateAttr(doc, C.HPDF_INFO_CREATION_DATE, date)    
    C.HPDF_SetInfoDateAttr(doc, C.HPDF_INFO_MOD_DATE, date)    
    C.HPDF_Page_SetSize (page, C.HPDF_PAGE_SIZE_A4, C.HPDF_PAGE_PORTRAIT)
    C.HPDF_Page_SetFontAndSize (page, font, font_size)
    local line_height = line_space * C.HPDF_Font_GetCapHeight(font) * font_size / 1000
    C.HPDF_Page_SetTextLeading(page, line_height)

    return setmetatable({ 
        line_space = line_space,
        line_height = line_height,
        font = font,
        font_size = font_size,
        width = C.HPDF_Page_GetWidth(page),
        height = C.HPDF_Page_GetHeight(page),
        C = C, 
        page = page, 
        doc = doc 
    }, mt)
end

function _M.save(self, filename)
    local doc = self.doc
    C.HPDF_SaveToFile(doc, filename)
    C.HPDF_Free(doc)
end

function _M.compress(self)
    C.HPDF_SetCompressionMode(self.doc, 15)
end

function _M.get_font_ttf(self, name)
    local font = C.HPDF_LoadTTFontFromFile(self.doc, name, 1)
    return C.HPDF_GetFont(self.doc, font, "CP1250")
end

function _M.get_font(self, name)
    return C.HPDF_GetFont(self.doc, name, nil)
end

function _M.set_font(self, font, size)
    if size and size ~= self.font_size then self.font_size = size end
    if font then self.font = font end
    self.line_height = _M.get_line_height(self)
    C.HPDF_Page_SetFontAndSize (self.page, self.font, self.font_size)
    return self.line_height
end

function _M.set_margin(self, top, left, bottom, right)
    if top and not left then left = top end
    if top and not bottom then bottom = top end
    if left and not right then right = left end
    self.margin_top = top
    self.margin_left = left
    self.margin_bottom = bottom
    self.margin_right = right
    local height = self.height
    local width = self.width
    self.content_x = left
    self.content_y = height - top
    self.content_right = width - left
    self.content_width = width - left - right
    self.content_height = height - top - bottom
end

function _M.get_line_height(self)
    local font = self.font
    local size = self.font_size
    local line = self.line_space
    return line * C.HPDF_Font_GetCapHeight(font) * size / 1000
end

function _M.add_page(self)
    local doc = self.doc
    local page = C.HPDF_AddPage(doc)
    C.HPDF_Page_SetSize(page, C.HPDF_PAGE_SIZE_A4, C.HPDF_PAGE_PORTRAIT)
    self.page = page
    _M.set_font(self)
end

function _M.line_spacing(self, line)
    C.HPDF_Page_SetTextLeading(self.page, line)
end

function _M.write(self, text)
    local page = self.page
    C.HPDF_Page_BeginText(page)
    C.HPDF_Page_ShowText(page, text)
    C.HPDF_Page_EndText(page)
end

function _M.text_width(self, text)
    local page = self.page
    return C.HPDF_Page_TextWidth(page, text)
end

function _M.paragraph(self, y, text, indent, align)
    local height = self.line_height
    local left = self.margin_left + (indent or 0)
    local bottom = self.margin_bottom
    local content = self.content_width
    local tw = _M.text_width(self, text)
    local th = ceil(tw / (content - 10)) * height
    if y - th - height <= bottom then
        _M.add_page(self)
        y = self.content_y
    end
    local curLine = y - th
    
    _M.cell(self, left, y, content, th, text, align)

    return curLine - height, curLine
end

function _M.cell(self, x, y, width, height, text, align)
    align = align or C.HPDF_TALIGN_JUSTIFY
    local page = self.page
    C.HPDF_Page_BeginText(page)
    C.HPDF_Page_TextRect(page, x, y, x + width, y - height, text, align, nil)
    C.HPDF_Page_EndText(page)
end

function _M.rect(self, x, y, width, height)
    local page = self.page
    C.HPDF_Page_Rectangle(page, x, y, width, height);
    C.HPDF_Page_Stroke(page)
end

function _M.get_size(self)
    local page = self.page
    self.width = C.HPDF_Page_GetWidth(page)
    self.height = C.HPDF_Page_GetHeight(page)
end

function _M.load_png(self, filename)
    return C.HPDF_LoadPngImageFromFile(self.doc, filename)
end

function _M.load_jpeg(self, filename)
    return C.HPDF_LoadJpegImageFromFile(self.doc, filename)
end

function _M.draw_image(self, image, x, y, width, height)
    local iw = C.HPDF_Image_GetWidth(image)
    local ih = C.HPDF_Image_GetHeight(image)
    local h = height and height or ih * width / iw
    local py = self.height - h - y
    C.HPDF_Page_DrawImage(self.page, image, x, py, width, h) 
end

function _M.draw_line(self, x, y, width, height)
    local page = self.page
    height = height or 0
    C.HPDF_Page_MoveTo(page, x, y)
    C.HPDF_Page_LineTo(page, x + width, y - height)
    C.HPDF_Page_Stroke(page)
end

return _M
