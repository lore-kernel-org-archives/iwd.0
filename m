Content-Type: multipart/mixed; boundary="===============2680045527130048692=="
MIME-Version: 1.0
From: Fangrui Song <i at maskray.me>
To: iwd at lists.01.org
Subject: [PATCH] Set retain attribute on C identifier name sections referenced
 by __start_/__stop_
Date: Wed, 10 Nov 2021 19:07:58 -0800
Message-ID: <20211111030758.2005309-1-i@maskray.me>

--===============2680045527130048692==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

LLD 13 and GNU ld 2.37 support -z start-stop-gc which allows garbage
collection of C identifier name sections despite the __start_/__stop_
references. GNU ld before 2015-10 had the behavior as well. Simply set
the retain attribute so that GCC 11 (if configure-time binutils is 2.36
or newer)/Clang 13 will set the SHF_GNU_RETAIN section attribute to
prevent garbage collection.

Without the patch, there are linker errors with -z start-stop-gc (LLD defau=
lt)
when -Wl,--gc-sections is used:

```
ld.lld: error: undefined symbol: __start___eap
>>> referenced by eap.c
>>>               src/eap.o:(eap_init)
```

The remain attribute will not be needed if the metadata sections are
referenced by code directly.
---
 client/command.h    | 12 +++++++-----
 client/dbus-proxy.h | 13 ++++++++-----
 src/eap-private.h   |  6 +++++-
 src/module.h        | 20 +++++++++++++-------
 4 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/client/command.h b/client/command.h
index d906dc9b..5d5df7fe 100644
--- a/client/command.h
+++ b/client/command.h
@@ -82,11 +82,13 @@ struct command_family_desc {
 	void (*exit)(void);
 } __attribute__((aligned(8)));
 =

-#define COMMAND_FAMILY(name, init, exit)				\
-	static struct command_family_desc __command_family_ ## name	\
-		__attribute__((used, section("__command"), aligned(8))) =3D {\
-			#name, init, exit				\
-		};							\
+#define COMMAND_FAMILY(name, init, exit)                                  =
     \
+	_Pragma("GCC diagnostic push")                                         \
+	_Pragma("GCC diagnostic ignored \"-Wattributes\"")                     \
+        static struct command_family_desc __command_family_##name         =
     \
+	__attribute__((used, retain, section("__command"), aligned(8))) =3D {    \
+		#name, init, exit};                                            \
+	_Pragma("GCC diagnostic pop")
 =

 bool command_init(char **argv, int argc);
 void command_exit(void);
diff --git a/client/dbus-proxy.h b/client/dbus-proxy.h
index 6852a378..54e95746 100644
--- a/client/dbus-proxy.h
+++ b/client/dbus-proxy.h
@@ -117,11 +117,14 @@ struct interface_type_desc {
 	void (*exit)(void);
 } __attribute__((aligned(8)));
 =

-#define INTERFACE_TYPE(interface, init, exit)				\
-	static struct interface_type_desc __interface_type_ ## interface\
-		__attribute__((used, section("__interface"), aligned(8))) =3D {\
-			#interface, init, exit				\
-		};							\
+#define INTERFACE_TYPE(interface, init, exit)				              \
+	_Pragma("GCC diagnostic push")                                           =
     \
+	_Pragma("GCC diagnostic ignored \"-Wattributes\"")                       =
     \
+	static struct interface_type_desc __interface_type_ ## interface         =
     \
+		__attribute__((used, retain, section("__interface"), aligned(8))) =3D { \
+			#interface, init, exit				              \
+		};								      \
+	_Pragma("GCC diagnostic pop")
 =

 bool dbus_proxy_init(void);
 bool dbus_proxy_exit(void);
diff --git a/src/eap-private.h b/src/eap-private.h
index 5121a330..1eef6bf4 100644
--- a/src/eap-private.h
+++ b/src/eap-private.h
@@ -94,10 +94,14 @@ struct eap_method_desc {
 } __attribute__((aligned(8)));
 =

 #define EAP_METHOD_BUILTIN(name, init, exit)				\
+	_Pragma("GCC diagnostic push")					\
+	_Pragma("GCC diagnostic ignored \"-Wattributes\"")		\
 	static struct eap_method_desc __eap_builtin_ ## name		\
-		__attribute__((used, section("__eap"), aligned(8))) =3D {	\
+		__attribute__((used, retain, section("__eap"),		\
+			       aligned(8))) =3D {				\
 			#name, init, exit				\
 		};							\
+	_Pragma("GCC diagnostic pop")
 =

 int eap_register_method(struct eap_method *method);
 int eap_unregister_method(struct eap_method *method);
diff --git a/src/module.h b/src/module.h
index 8e1a9904..b4ec1284 100644
--- a/src/module.h
+++ b/src/module.h
@@ -33,19 +33,25 @@ struct iwd_module_depends {
 };
 =

 #define IWD_MODULE(name, init, exit)					\
+	_Pragma("GCC diagnostic push")				  	\
+	_Pragma("GCC diagnostic ignored \"-Wattributes\"")	        \
 	static struct iwd_module_desc __iwd_module_ ## name		\
-		__attribute__((used, section("__iwd_module"), aligned(8))) =3D {\
+		__attribute__((used, retain, section("__iwd_module"),   \
+			       aligned(8))) =3D {			 	\
 			#name, init, exit				\
-		};
+		};							\
+	_Pragma("GCC diagnostic pop")
 =

 #define IWD_MODULE_DEPENDS(name, dep)					\
-	static struct iwd_module_depends				\
-				__iwd_module__##name##_##dep		\
-		__attribute__((used, section("__iwd_module_dep"),       \
-					aligned(8))) =3D {		\
+	_Pragma("GCC diagnostic push")                                  \
+	_Pragma("GCC diagnostic ignored \"-Wattributes\"")              \
+	static struct iwd_module_depends __iwd_module__##name##_##dep	\
+		__attribute__((used, retain,				\
+			section("__iwd_module_dep"), aligned(8))) =3D {	\
 			.self =3D #name,					\
 			.target =3D #dep,					\
-		};
+		};						        \
+	_Pragma("GCC diagnostic pop")
 =

 int iwd_modules_init(void);
 void iwd_modules_exit(void);
-- =

2.34

--===============2680045527130048692==--

