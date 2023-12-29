Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F8D7E1
	for <iwd@lists.linux.dev>; Fri, 29 Dec 2023 00:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: iwd@lists.linux.dev
Cc: Sam James <sam@gentoo.org>
Subject: [PATCH] configure.ac: fix bashism
Date: Fri, 29 Dec 2023 00:38:40 +0000
Message-ID: <20231229003840.4152342-1-sam@gentoo.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

configure scripts need to be runnable with a POSIX-compliant /bin/sh.

On many (but not all!) systems, /bin/sh is provided by Bash, so errors
like this aren't spotted. Notably Debian defaults to /bin/sh provided
by dash which doesn't tolerate such bashisms as '+='.

This retains compatibility with bash. Just copy the expanded append like
we do on the line above.

Fixes warnings like:
```
./configure: 13352: CFLAGS+= -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2: not found
```
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 3e9da6bb..57874ab7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -44,7 +44,7 @@ AC_ARG_ENABLE(optimization, AS_HELP_STRING([--disable-optimization],
 
 if (test "${enable_optimization}" != "no"); then
 	CFLAGS="$CFLAGS -O2"
-	CFLAGS+=" -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2"
+	CFLAGS="$CFLAGS -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2"
 fi
 
 AC_ARG_ENABLE(debug, AS_HELP_STRING([--enable-debug],
-- 
2.43.0

