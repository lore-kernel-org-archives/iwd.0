Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F95B7E
	for <iwd@lists.linux.dev>; Thu, 16 Jun 2022 00:02:40 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id c21so17347574wrb.1
        for <iwd@lists.linux.dev>; Wed, 15 Jun 2022 17:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HeUk5YNtIO9TeLXsTOkL/ZW/66PCg3ok0c0E8E/QVV8=;
        b=i8S4TMzCV/aNEVLCjr3qCfcQHHXQgCBld52FSb+i797M8rz1myX3TJqmqzKWzqMWsp
         eG34wrDHuiA5/44huTsPR/mlhIYQ++cmDX2Lzcmz6CyT9kztbsCiQ6X2NGH2BnML6RiL
         1nlOr9N2KTQQ1MVqJpgQp8oKBA5OqT+FqSCVkZgSpH08uIMwdxcdEeC9kPEsLDHoykpR
         Xh/RVahfTShghkuJNZZAhdYHzS5ww9TlMDfy//IW4wcVTGLMe0GiNaCZaEpVmIq1032M
         39eDELcULtuNk2W02RxmYivZzCue+Rv7RXhTau1A8JVFyW69nXsQTdfnNcDIEp9j1kGW
         z6ZQ==
X-Gm-Message-State: AJIora/7pm0v+6paT46Jxy4dAD05aFeDeUUKHDA+4OiPP0BuAtsWyQZq
	GOK/DIkCsAhdYrRdkmHKgZ0XYvhhJgU=
X-Google-Smtp-Source: AGRyM1t94Gvnv4yjWU9eLRAmGzPDaBx8wDm0pmepV6p8ojaGpE3qhhQAyPrLvJf3+16LyoxTuIL5hA==
X-Received: by 2002:adf:d205:0:b0:213:b49a:9fc7 with SMTP id j5-20020adfd205000000b00213b49a9fc7mr1991770wrh.589.1655337758266;
        Wed, 15 Jun 2022 17:02:38 -0700 (PDT)
Received: from iss.Home ([82.213.231.20])
        by smtp.gmail.com with ESMTPSA id az10-20020adfe18a000000b00210396b2eaesm337452wrb.45.2022.06.15.17.02.37
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:02:37 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 01/15] netconfig: Fix address format validation
Date: Thu, 16 Jun 2022 02:02:17 +0200
Message-Id: <20220616000231.1966008-1-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the wrong negation in the error check.  Check that there are no extra
characters after prefix length suffix.  Reset errno 0 before the strtoul
call, as recommended by the manpage.
---
 src/netconfig.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 2ab03b90..4a70b0ca 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -515,6 +515,7 @@ static struct l_rtnl_address *netconfig_get_static6_address(
 {
 	L_AUTO_FREE_VAR(char *, ip);
 	char *p;
+	char *endp;
 	struct l_rtnl_address *ret;
 	uint32_t prefix_len = 128;
 
@@ -530,8 +531,9 @@ static struct l_rtnl_address *netconfig_get_static6_address(
 	if (*++p == '\0')
 		goto no_prefix_len;
 
-	prefix_len = strtoul(p, NULL, 10);
-	if (!unlikely(errno == EINVAL || errno == ERANGE ||
+	errno = 0;
+	prefix_len = strtoul(p, &endp, 10);
+	if (unlikely(*endp != '\0' || errno ||
 			!prefix_len || prefix_len > 128)) {
 		l_error("netconfig: Invalid prefix '%s' provided in network"
 				" configuration file", p);
-- 
2.34.1

