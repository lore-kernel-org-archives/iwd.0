Content-Type: multipart/mixed; boundary="===============0107857367063513080=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 1/3] shared: add jsmn.h header for JSON parser
Date: Wed, 08 Dec 2021 13:36:34 -0800
Message-ID: <20211208213636.1697316-1-prestwoj@gmail.com>

--===============0107857367063513080==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 shared/jsmn.h | 471 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 471 insertions(+)
 create mode 100644 shared/jsmn.h

diff --git a/shared/jsmn.h b/shared/jsmn.h
new file mode 100644
index 00000000..8ac14c1b
--- /dev/null
+++ b/shared/jsmn.h
@@ -0,0 +1,471 @@
+/*
+ * MIT License
+ *
+ * Copyright (c) 2010 Serge Zaitsev
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy
+ * of this software and associated documentation files (the "Software"), t=
o deal
+ * in the Software without restriction, including without limitation the r=
ights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL=
 THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN THE
+ * SOFTWARE.
+ */
+#ifndef JSMN_H
+#define JSMN_H
+
+#include <stddef.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#ifdef JSMN_STATIC
+#define JSMN_API static
+#else
+#define JSMN_API extern
+#endif
+
+/**
+ * JSON type identifier. Basic types are:
+ * 	o Object
+ * 	o Array
+ * 	o String
+ * 	o Other primitive: number, boolean (true/false) or null
+ */
+typedef enum {
+  JSMN_UNDEFINED =3D 0,
+  JSMN_OBJECT =3D 1 << 0,
+  JSMN_ARRAY =3D 1 << 1,
+  JSMN_STRING =3D 1 << 2,
+  JSMN_PRIMITIVE =3D 1 << 3
+} jsmntype_t;
+
+enum jsmnerr {
+  /* Not enough tokens were provided */
+  JSMN_ERROR_NOMEM =3D -1,
+  /* Invalid character inside JSON string */
+  JSMN_ERROR_INVAL =3D -2,
+  /* The string is not a full JSON packet, more bytes expected */
+  JSMN_ERROR_PART =3D -3
+};
+
+/**
+ * JSON token description.
+ * type		type (object, array, string etc.)
+ * start	start position in JSON data string
+ * end		end position in JSON data string
+ */
+typedef struct jsmntok {
+  jsmntype_t type;
+  int start;
+  int end;
+  int size;
+#ifdef JSMN_PARENT_LINKS
+  int parent;
+#endif
+} jsmntok_t;
+
+/**
+ * JSON parser. Contains an array of token blocks available. Also stores
+ * the string being parsed now and current position in that string.
+ */
+typedef struct jsmn_parser {
+  unsigned int pos;     /* offset in the JSON string */
+  unsigned int toknext; /* next token to allocate */
+  int toksuper;         /* superior token node, e.g. parent object or arra=
y */
+} jsmn_parser;
+
+/**
+ * Create JSON parser over an array of tokens
+ */
+JSMN_API void jsmn_init(jsmn_parser *parser);
+
+/**
+ * Run JSON parser. It parses a JSON data string into and array of tokens,=
 each
+ * describing
+ * a single JSON object.
+ */
+JSMN_API int jsmn_parse(jsmn_parser *parser, const char *js, const size_t =
len,
+                        jsmntok_t *tokens, const unsigned int num_tokens);
+
+#ifndef JSMN_HEADER
+/**
+ * Allocates a fresh unused token from the token pool.
+ */
+static jsmntok_t *jsmn_alloc_token(jsmn_parser *parser, jsmntok_t *tokens,
+                                   const size_t num_tokens) {
+  jsmntok_t *tok;
+  if (parser->toknext >=3D num_tokens) {
+    return NULL;
+  }
+  tok =3D &tokens[parser->toknext++];
+  tok->start =3D tok->end =3D -1;
+  tok->size =3D 0;
+#ifdef JSMN_PARENT_LINKS
+  tok->parent =3D -1;
+#endif
+  return tok;
+}
+
+/**
+ * Fills token type and boundaries.
+ */
+static void jsmn_fill_token(jsmntok_t *token, const jsmntype_t type,
+                            const int start, const int end) {
+  token->type =3D type;
+  token->start =3D start;
+  token->end =3D end;
+  token->size =3D 0;
+}
+
+/**
+ * Fills next available token with JSON primitive.
+ */
+static int jsmn_parse_primitive(jsmn_parser *parser, const char *js,
+                                const size_t len, jsmntok_t *tokens,
+                                const size_t num_tokens) {
+  jsmntok_t *token;
+  int start;
+
+  start =3D parser->pos;
+
+  for (; parser->pos < len && js[parser->pos] !=3D '\0'; parser->pos++) {
+    switch (js[parser->pos]) {
+#ifndef JSMN_STRICT
+    /* In strict mode primitive must be followed by "," or "}" or "]" */
+    case ':':
+#endif
+    case '\t':
+    case '\r':
+    case '\n':
+    case ' ':
+    case ',':
+    case ']':
+    case '}':
+      goto found;
+    default:
+                   /* to quiet a warning from gcc*/
+      break;
+    }
+    if (js[parser->pos] < 32 || js[parser->pos] >=3D 127) {
+      parser->pos =3D start;
+      return JSMN_ERROR_INVAL;
+    }
+  }
+#ifdef JSMN_STRICT
+  /* In strict mode primitive must be followed by a comma/object/array */
+  parser->pos =3D start;
+  return JSMN_ERROR_PART;
+#endif
+
+found:
+  if (tokens =3D=3D NULL) {
+    parser->pos--;
+    return 0;
+  }
+  token =3D jsmn_alloc_token(parser, tokens, num_tokens);
+  if (token =3D=3D NULL) {
+    parser->pos =3D start;
+    return JSMN_ERROR_NOMEM;
+  }
+  jsmn_fill_token(token, JSMN_PRIMITIVE, start, parser->pos);
+#ifdef JSMN_PARENT_LINKS
+  token->parent =3D parser->toksuper;
+#endif
+  parser->pos--;
+  return 0;
+}
+
+/**
+ * Fills next token with JSON string.
+ */
+static int jsmn_parse_string(jsmn_parser *parser, const char *js,
+                             const size_t len, jsmntok_t *tokens,
+                             const size_t num_tokens) {
+  jsmntok_t *token;
+
+  int start =3D parser->pos;
+  =

+  /* Skip starting quote */
+  parser->pos++;
+  =

+  for (; parser->pos < len && js[parser->pos] !=3D '\0'; parser->pos++) {
+    char c =3D js[parser->pos];
+
+    /* Quote: end of string */
+    if (c =3D=3D '\"') {
+      if (tokens =3D=3D NULL) {
+        return 0;
+      }
+      token =3D jsmn_alloc_token(parser, tokens, num_tokens);
+      if (token =3D=3D NULL) {
+        parser->pos =3D start;
+        return JSMN_ERROR_NOMEM;
+      }
+      jsmn_fill_token(token, JSMN_STRING, start + 1, parser->pos);
+#ifdef JSMN_PARENT_LINKS
+      token->parent =3D parser->toksuper;
+#endif
+      return 0;
+    }
+
+    /* Backslash: Quoted symbol expected */
+    if (c =3D=3D '\\' && parser->pos + 1 < len) {
+      int i;
+      parser->pos++;
+      switch (js[parser->pos]) {
+      /* Allowed escaped symbols */
+      case '\"':
+      case '/':
+      case '\\':
+      case 'b':
+      case 'f':
+      case 'r':
+      case 'n':
+      case 't':
+        break;
+      /* Allows escaped symbol \uXXXX */
+      case 'u':
+        parser->pos++;
+        for (i =3D 0; i < 4 && parser->pos < len && js[parser->pos] !=3D '=
\0';
+             i++) {
+          /* If it isn't a hex character we have an error */
+          if (!((js[parser->pos] >=3D 48 && js[parser->pos] <=3D 57) ||   =
/* 0-9 */
+                (js[parser->pos] >=3D 65 && js[parser->pos] <=3D 70) ||   =
/* A-F */
+                (js[parser->pos] >=3D 97 && js[parser->pos] <=3D 102))) { =
/* a-f */
+            parser->pos =3D start;
+            return JSMN_ERROR_INVAL;
+          }
+          parser->pos++;
+        }
+        parser->pos--;
+        break;
+      /* Unexpected symbol */
+      default:
+        parser->pos =3D start;
+        return JSMN_ERROR_INVAL;
+      }
+    }
+  }
+  parser->pos =3D start;
+  return JSMN_ERROR_PART;
+}
+
+/**
+ * Parse JSON string and fill tokens.
+ */
+JSMN_API int jsmn_parse(jsmn_parser *parser, const char *js, const size_t =
len,
+                        jsmntok_t *tokens, const unsigned int num_tokens) {
+  int r;
+  int i;
+  jsmntok_t *token;
+  int count =3D parser->toknext;
+
+  for (; parser->pos < len && js[parser->pos] !=3D '\0'; parser->pos++) {
+    char c;
+    jsmntype_t type;
+
+    c =3D js[parser->pos];
+    switch (c) {
+    case '{':
+    case '[':
+      count++;
+      if (tokens =3D=3D NULL) {
+        break;
+      }
+      token =3D jsmn_alloc_token(parser, tokens, num_tokens);
+      if (token =3D=3D NULL) {
+        return JSMN_ERROR_NOMEM;
+      }
+      if (parser->toksuper !=3D -1) {
+        jsmntok_t *t =3D &tokens[parser->toksuper];
+#ifdef JSMN_STRICT
+        /* In strict mode an object or array can't become a key */
+        if (t->type =3D=3D JSMN_OBJECT) {
+          return JSMN_ERROR_INVAL;
+        }
+#endif
+        t->size++;
+#ifdef JSMN_PARENT_LINKS
+        token->parent =3D parser->toksuper;
+#endif
+      }
+      token->type =3D (c =3D=3D '{' ? JSMN_OBJECT : JSMN_ARRAY);
+      token->start =3D parser->pos;
+      parser->toksuper =3D parser->toknext - 1;
+      break;
+    case '}':
+    case ']':
+      if (tokens =3D=3D NULL) {
+        break;
+      }
+      type =3D (c =3D=3D '}' ? JSMN_OBJECT : JSMN_ARRAY);
+#ifdef JSMN_PARENT_LINKS
+      if (parser->toknext < 1) {
+        return JSMN_ERROR_INVAL;
+      }
+      token =3D &tokens[parser->toknext - 1];
+      for (;;) {
+        if (token->start !=3D -1 && token->end =3D=3D -1) {
+          if (token->type !=3D type) {
+            return JSMN_ERROR_INVAL;
+          }
+          token->end =3D parser->pos + 1;
+          parser->toksuper =3D token->parent;
+          break;
+        }
+        if (token->parent =3D=3D -1) {
+          if (token->type !=3D type || parser->toksuper =3D=3D -1) {
+            return JSMN_ERROR_INVAL;
+          }
+          break;
+        }
+        token =3D &tokens[token->parent];
+      }
+#else
+      for (i =3D parser->toknext - 1; i >=3D 0; i--) {
+        token =3D &tokens[i];
+        if (token->start !=3D -1 && token->end =3D=3D -1) {
+          if (token->type !=3D type) {
+            return JSMN_ERROR_INVAL;
+          }
+          parser->toksuper =3D -1;
+          token->end =3D parser->pos + 1;
+          break;
+        }
+      }
+      /* Error if unmatched closing bracket */
+      if (i =3D=3D -1) {
+        return JSMN_ERROR_INVAL;
+      }
+      for (; i >=3D 0; i--) {
+        token =3D &tokens[i];
+        if (token->start !=3D -1 && token->end =3D=3D -1) {
+          parser->toksuper =3D i;
+          break;
+        }
+      }
+#endif
+      break;
+    case '\"':
+      r =3D jsmn_parse_string(parser, js, len, tokens, num_tokens);
+      if (r < 0) {
+        return r;
+      }
+      count++;
+      if (parser->toksuper !=3D -1 && tokens !=3D NULL) {
+        tokens[parser->toksuper].size++;
+      }
+      break;
+    case '\t':
+    case '\r':
+    case '\n':
+    case ' ':
+      break;
+    case ':':
+      parser->toksuper =3D parser->toknext - 1;
+      break;
+    case ',':
+      if (tokens !=3D NULL && parser->toksuper !=3D -1 &&
+          tokens[parser->toksuper].type !=3D JSMN_ARRAY &&
+          tokens[parser->toksuper].type !=3D JSMN_OBJECT) {
+#ifdef JSMN_PARENT_LINKS
+        parser->toksuper =3D tokens[parser->toksuper].parent;
+#else
+        for (i =3D parser->toknext - 1; i >=3D 0; i--) {
+          if (tokens[i].type =3D=3D JSMN_ARRAY || tokens[i].type =3D=3D JS=
MN_OBJECT) {
+            if (tokens[i].start !=3D -1 && tokens[i].end =3D=3D -1) {
+              parser->toksuper =3D i;
+              break;
+            }
+          }
+        }
+#endif
+      }
+      break;
+#ifdef JSMN_STRICT
+    /* In strict mode primitives are: numbers and booleans */
+    case '-':
+    case '0':
+    case '1':
+    case '2':
+    case '3':
+    case '4':
+    case '5':
+    case '6':
+    case '7':
+    case '8':
+    case '9':
+    case 't':
+    case 'f':
+    case 'n':
+      /* And they must not be keys of the object */
+      if (tokens !=3D NULL && parser->toksuper !=3D -1) {
+        const jsmntok_t *t =3D &tokens[parser->toksuper];
+        if (t->type =3D=3D JSMN_OBJECT ||
+            (t->type =3D=3D JSMN_STRING && t->size !=3D 0)) {
+          return JSMN_ERROR_INVAL;
+        }
+      }
+#else
+    /* In non-strict mode every unquoted value is a primitive */
+    default:
+#endif
+      r =3D jsmn_parse_primitive(parser, js, len, tokens, num_tokens);
+      if (r < 0) {
+        return r;
+      }
+      count++;
+      if (parser->toksuper !=3D -1 && tokens !=3D NULL) {
+        tokens[parser->toksuper].size++;
+      }
+      break;
+
+#ifdef JSMN_STRICT
+    /* Unexpected char in strict mode */
+    default:
+      return JSMN_ERROR_INVAL;
+#endif
+    }
+  }
+
+  if (tokens !=3D NULL) {
+    for (i =3D parser->toknext - 1; i >=3D 0; i--) {
+      /* Unmatched opened object or array */
+      if (tokens[i].start !=3D -1 && tokens[i].end =3D=3D -1) {
+        return JSMN_ERROR_PART;
+      }
+    }
+  }
+
+  return count;
+}
+
+/**
+ * Creates a new parser based over a given buffer with an array of tokens
+ * available.
+ */
+JSMN_API void jsmn_init(jsmn_parser *parser) {
+  parser->pos =3D 0;
+  parser->toknext =3D 0;
+  parser->toksuper =3D -1;
+}
+
+#endif /* JSMN_HEADER */
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* JSMN_H */
-- =

2.31.1

--===============0107857367063513080==--

