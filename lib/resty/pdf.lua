-- Copyright 2015 @ Anton Heryanto
-- based on extensive work by https://github.com/tavikukko/lua-resty-hpdf/
local ffi = require 'ffi'
local ffi_cdef = ffi.cdef
local name = 'libhpdf'
if os == 'Windows' or os == 'OSX' then 
    name = name .. (os == 'Windows' and '.dll' or '.dylib')
end
local C = ffi.load(name)

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
typedef unsigned int HPDF_UINT;
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
        HPDF_PAGE_SIZE_EOF} HPDF_PageSizes;
typedef enum _HPDF_PageDirection {
        HPDF_PAGE_PORTRAIT = 0,
        HPDF_PAGE_LANDSCAPE} HPDF_PageDirection;
typedef enum _HPDF_PageNumStyle {
    HPDF_PAGE_NUM_STYLE_DECIMAL = 0,
    HPDF_PAGE_NUM_STYLE_UPPER_ROMAN,
    HPDF_PAGE_NUM_STYLE_LOWER_ROMAN,
    HPDF_PAGE_NUM_STYLE_UPPER_LETTERS,
    HPDF_PAGE_NUM_STYLE_LOWER_LETTERS,
    HPDF_PAGE_NUM_STYLE_EOF} HPDF_PageNumStyle;
typedef signed int HPDF_BOOL;
typedef float HPDF_REAL;
const char * HPDF_GetVersion();
typedef void (*HPDF_Error_Handler) (unsigned long error_no, unsigned long detail_no, 
                        void  *user_data);
void * HPDF_New(HPDF_Error_Handler user_error_fn, void *user_data);
void * HPDF_SetCompressionMode(HPDF_Doc pdf, HPDF_UINT mode);
void * HPDF_AddPage(HPDF_Doc pdf);
float HPDF_Page_GetHeight(HPDF_Page page);
float HPDF_Page_GetWidth(HPDF_Page page);
void * HPDF_GetFont(HPDF_Doc pdf, const char *font_name, const char *encoding_name);
void * HPDF_Page_SetFontAndSize(HPDF_Page page,HPDF_Font font, HPDF_REAL size);
void * HPDF_Page_BeginText(HPDF_Page page);
void * HPDF_Page_TextOut(HPDF_Page page, HPDF_REAL xpos, HPDF_REAL ypos, const char *text);
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
const char* HPDF_LoadTTFontFromFile(HPDF_Doc pdf, const char *file_name, HPDF_BOOL embedding);
const char* HPDF_LoadType1FontFromFile(HPDF_Doc pdf, const char *afm_file_name, const char *data_file_name);
const char* HPDF_LoadTTFontFromFile2(HPDF_Doc pdf, const char *file_name, HPDF_UINT index, HPDF_BOOL embedding);
void * HPDF_Page_TextRect(HPDF_Page page, HPDF_REAL left, HPDF_REAL top, HPDF_REAL right, 
                        HPDF_REAL bottom, const char *text, HPDF_TextAlignment align, HPDF_UINT *len);
HPDF_REAL HPDF_Page_TextWidth(HPDF_Page page, const char *text);
void * HPDF_Page_SetSize(HPDF_Page page, HPDF_PageSizes size, HPDF_PageDirection direction);
void * HPDF_Page_SetTextLeading(HPDF_Page page, HPDF_REAL value);
void * HPDF_Page_Rectangle(HPDF_Page page, HPDF_REAL x, HPDF_REAL y, HPDF_REAL width, HPDF_REAL height);
void * HPDF_Page_Stroke(HPDF_Page page);
void * HPDF_Page_GSave(HPDF_Page page);
void * HPDF_Page_GRestore(HPDF_Page page);
void * HPDF_Page_GetLineWidth(HPDF_Page page);
void * HPDF_Page_MoveTextPos(HPDF_Page page, HPDF_REAL x, HPDF_REAL y);
void * HPDF_Page_MoveTo(HPDF_Page page, HPDF_REAL x, HPDF_REAL y);
void * HPDF_Page_LineTo(HPDF_Page page, HPDF_REAL x, HPDF_REAL y);
void * HPDF_Page_SetLineWidth(HPDF_Page page, HPDF_REAL line_width);
void * HPDF_Page_SetGrayFill(HPDF_Page page, HPDF_REAL gray);
void * HPDF_Page_SetGrayStroke(HPDF_Page page, HPDF_REAL gray);
void * HPDF_Page_Circle(HPDF_Page page, HPDF_REAL x, HPDF_REAL y, HPDF_REAL ray);
void * HPDF_Page_Concat(HPDF_Page page,HPDF_REAL a, HPDF_REAL b, HPDF_REAL c, HPDF_REAL d, 
                                HPDF_REAL x, HPDF_REAL y);
void * HPDF_Page_ShowText(HPDF_Page page,const char *text);
void * HPDF_Page_SetTextMatrix(HPDF_Page page, HPDF_REAL a, HPDF_REAL b, HPDF_REAL c, HPDF_REAL d, HPDF_REAL x, HPDF_REAL y);
void * HPDF_AddPageLabel(HPDF_Doc pdf, HPDF_UINT page_num, HPDF_PageNumStyle style, HPDF_UINT first_page, 
                        const char *prefix);
void * HPDF_SaveToFile(HPDF_Doc pdf, const char *file_name);
void * HPDF_LoadPngImageFromFile(HPDF_Doc pdf, const char  *filename);
void * HPDF_LoadJpegImageFromFile(HPDF_Doc pdf, const char  *filename);
void * HPDF_Page_DrawImage (HPDF_Page page, HPDF_Image image, HPDF_REAL x, HPDF_REAL y, HPDF_REAL width, HPDF_REAL height);
HPDF_UINT HPDF_Image_GetWidth(HPDF_Image image);
HPDF_UINT HPDF_Image_GetHeight(HPDF_Image image);
]]

local setmetatable = setmetatable
local format = string.format
local tonumber = tonumber
local pcall = pcall
local log = ngx.say
local WARN = ngx.WARN

local ok, new_tab = pcall(require, "table.new")
if not ok then
    new_tab = function (narr, nrec) return {} end
end

local function err(error_no, detail_no, user_data)
    log(WARN, format('error no: %04X, detail no: %d', tonumber(error_no), tonumber(detail_no)))
end

local _M = new_tab(0, 10)
local mt = { __index = _M }

_M.VERSION = '0.1.0'

function _M.new(self, err_fn)
    local doc = C.HPDF_New(err, nil)
    if not doc then
        return nil, 'initialization failed'
    end
    local page = C.HPDF_AddPage(doc)
    local font = C.HPDF_GetFont(doc, "Times-Roman", nil)

    C.HPDF_Page_SetSize (page, C.HPDF_PAGE_SIZE_A4, C.HPDF_PAGE_PORTRAIT)
    C.HPDF_Page_SetFontAndSize (page, font, 12)
    return setmetatable({ 
        font = font,
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

function _M.get_font(self, name)
    return C.HPDF_GetFont(self.doc, name, nil)
end

function _M.set_font(self, font, size)
    if not size then size = 12 end
    if font then self.font = font end
    C.HPDF_Page_SetFontAndSize (self.page, self.font, size)
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

function _M.cell(self, x, y, width, height, text, align)
    align = align or C.HPDF_TALIGN_JUSTIFY
    local page = self.page
    C.HPDF_Page_BeginText(page)
    C.HPDF_Page_TextRect(page, x, y, x + width, y - height, text, align, nil)
    C.HPDF_Page_EndText(page)
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

function _M.draw_line(self, x, y, width)
    local page = self.page
    C.HPDF_Page_MoveTo(page, x, y)
    C.HPDF_Page_LineTo(page, x + width, y)
    C.HPDF_Page_Stroke(page)
end

return _M
