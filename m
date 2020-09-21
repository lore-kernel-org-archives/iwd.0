Content-Type: multipart/mixed; boundary="===============4221871190520766092=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/5] resolve: Exit methods if resolve is NULL
Date: Mon, 21 Sep 2020 21:04:21 +0200
Message-ID: <20200921190425.615855-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4221871190520766092==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If no resolve method gets configured, the resolve_new() call in
netconfig returns NULL.  To avoid adding checks netconfig every time
netconfig->resolve is used, add these checks directly in the resolve_*
methods.  Fixes the following crash:

src/netconfig.c:netconfig_destroy()
Aborting (signal 11) [/path/iwd]
++++++++ backtrace ++++++++
 #0  0x7f3ee427f210 in /lib/x86_64-linux-gnu/libc.so.6
 #1  0x43bcf4 in resolve_revert() at src/resolve.c:85
 #2  0x43ae2d in netconfig_destroy() at src/netconfig.c:1206
 #3  0x440cd6 in p2p_connection_reset() at src/p2p.c:662
 #4  0x47200f in process_unicast() at ell/genl.c:979
 #5  0x46e807 in io_callback() at ell/io.c:126
 #6  0x46d9bd in l_main_iterate() at ell/main.c:467 (discriminator 2)
 #7  0x46da8c in l_main_run() at ell/main.c:516
 #8  0x4047c6 in main() at src/main.c:506
 #9  0x7f3ee42600b3 in /lib/x86_64-linux-gnu/libc.so.6
+++++++++++++++++++++++++++
---
 src/resolve.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/resolve.c b/src/resolve.c
index 066e4c87..07eee5a9 100644
--- a/src/resolve.c
+++ b/src/resolve.c
@@ -60,7 +60,7 @@ static inline void _resolve_init(struct resolve *resolve,=
 uint32_t ifindex,
 =

 void resolve_add_dns(struct resolve *resolve, uint8_t type, char **dns_lis=
t)
 {
-	if (!dns_list || !*dns_list)
+	if (!resolve || !dns_list || !*dns_list)
 		return;
 =

 	if (!resolve->ops->add_dns)
@@ -71,7 +71,7 @@ void resolve_add_dns(struct resolve *resolve, uint8_t typ=
e, char **dns_list)
 =

 void resolve_add_domain_name(struct resolve *resolve, const char *domain_n=
ame)
 {
-	if (!domain_name)
+	if (!resolve || !domain_name)
 		return;
 =

 	if (!resolve->ops->add_domain_name)
@@ -82,7 +82,7 @@ void resolve_add_domain_name(struct resolve *resolve, con=
st char *domain_name)
 =

 void resolve_revert(struct resolve *resolve)
 {
-	if (!resolve->ops->revert)
+	if (!resolve || !resolve->ops->revert)
 		return;
 =

 	resolve->ops->revert(resolve);
@@ -90,6 +90,9 @@ void resolve_revert(struct resolve *resolve)
 =

 void resolve_free(struct resolve *resolve)
 {
+	if (!resolve)
+		return;
+
 	resolve->ops->destroy(resolve);
 }
 =

-- =

2.25.1

--===============4221871190520766092==--

