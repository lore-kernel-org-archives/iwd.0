Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C346E2913
	for <iwd@lists.linux.dev>; Thu,  7 Jul 2022 17:57:38 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id d10so7124494pfd.9
        for <iwd@lists.linux.dev>; Thu, 07 Jul 2022 10:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NBza7GTBinUd6pDhR8LmGnIFuQRHAGBueMNiYVmpyNY=;
        b=KL7txRJDycl//K1ae5w2kH90y9k9Vvr32QRaSX2Z9Qp1tE24J8zDEKsDIGyLnnqL8u
         K8jNKSNItyt+bS9oCVmWgjWcELfzvceQuISKGE2woFfzIChgoBN7wdDn9Lz0/f775+ZM
         HL7wh0J4borM0NhilsYgplxjO0lo0jCJaaWIgiCqx9Z3zOXT4+XLiILI+xoqxooiD7Lu
         tY6CYvzcJENmXCEr7WO3EJ4G71jvqviPx8j8G/GN/vGgzgC+jPg1Bfbn0l7hKXb5zwC5
         08hqo26XeVpRUTvQyR8m0wZQ6umIPFTLQUbh2hrKZP2RSWv/9B49xMEUMoA6Oi9i68rQ
         UcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NBza7GTBinUd6pDhR8LmGnIFuQRHAGBueMNiYVmpyNY=;
        b=XhiHK4WGIaZTzKw3BkVDmJAOf69J8CsFQ/ISJSYCpLnA0C4twmM4uF1P61KBaqO1jz
         mElPyCGybRuGuD8OikXcmOZLyAz0sID5nTQn1q1K55Ui1szsQtt7yV5CP0E1zq23xd82
         XNYv6yXiYqbnEO7HKbHE6VAXpfXLUAwdFCjj3KAzY3HbaHPWu9tRBeR2cUIGG3WbCF0W
         EsJEL91jtj4O7nbcfL0CPmtkXE6gga8Gs7yezMWwkYPVso/t+lHVdAu2TJlLeeWiU0AG
         dtQRln1sQx9JvGOdlKJAhRzcmTzb1UbjzGMEXp5rOuiHFTWf0qJxXenwRLfcF897FiQx
         nHfQ==
X-Gm-Message-State: AJIora9dVIhy0uduFW8ugeNXqMWJ1ykmzff5SHmUa2qwCeyVjrSTjS/N
	NYouByrS6ZN0SLZyN3TaPQC6suS9dHE=
X-Google-Smtp-Source: AGRyM1sLolCOn5DcIJNvxNAFEPXWM0w57RuU/59eUxSunBGGJRRn8jRFYmSJRzC0S4+XIeFVxXRt8w==
X-Received: by 2002:a17:90b:2152:b0:1ef:9c75:66d8 with SMTP id kt18-20020a17090b215200b001ef9c7566d8mr6765873pjb.5.1657216658045;
        Thu, 07 Jul 2022 10:57:38 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090322c300b001618b70dcc9sm28855223plg.101.2022.07.07.10.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 10:57:37 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 14/14] client: update ad-hoc table header
Date: Thu,  7 Jul 2022 10:55:11 -0700
Message-Id: <20220707175511.224597-14-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220707175511.224597-1-prestwoj@gmail.com>
References: <20220707175511.224597-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The table header needs to be adjusted to include spaces between
columns.
---
 client/ad-hoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/ad-hoc.c b/client/ad-hoc.c
index 33bff9ca..49c97f74 100644
--- a/client/ad-hoc.c
+++ b/client/ad-hoc.c
@@ -117,7 +117,7 @@ static enum cmd_status cmd_list(const char *device_name, char **argv, int argc)
 	struct l_queue *match =
 		proxy_interface_find_all(IWD_AD_HOC_INTERFACE, NULL, NULL);
 
-	display_table_header("Devices in Ad-Hoc Mode", MARGIN "%-*s%-*s",
+	display_table_header("Devices in Ad-Hoc Mode", MARGIN "%-*s  %-*s",
 				20, "Name", 8, "Started");
 
 	if (!match) {
-- 
2.34.1

