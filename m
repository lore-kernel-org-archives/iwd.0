Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76D43EA88
	for <iwd@lists.linux.dev>; Wed,  6 Dec 2023 15:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZM5Lg1I"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-77f320ca2d5so35644885a.1
        for <iwd@lists.linux.dev>; Wed, 06 Dec 2023 07:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701875236; x=1702480036; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rj82y449AvkdKesQQUHyj+VdUVbSc8ccNljz1Eh1eO4=;
        b=NZM5Lg1Ikx18TcK6N3S0nRbkSSRwa63JiulDZMDx4HAw/MofhuzLc51WqtveprYFow
         cqGVKCn0Xy49opABTtz3QOl8fCI3hqdqnFnEs4ita1MaISBN8HM/243oIj6iujWlO0Lb
         NtwXV1N9BCJFx9IsP8l2qEhOTdqix+PvNxBBsWKnshHHlx8/prRqH2bKHsX40MZD4GgA
         JMIniKYcfk563IFbdNkn1JkBIPnTepHGCNHQLnhZOzFlCsJyf2TegFg7SXdtoZndHvsz
         9CfRZAFlwxGOXVxXqwzOxb/E53BI7FjDEe+oCYeqaTwhvtb/Iz3yaXXoebNJZFLGJV5c
         ytDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701875236; x=1702480036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rj82y449AvkdKesQQUHyj+VdUVbSc8ccNljz1Eh1eO4=;
        b=iVCruRnQkgN2Tjtq4WaZgwlGjI1HHXhuQqAyg+hchgutN4HMu1/uhZWCaI6/Ypy+/3
         UGJUpq3BNl+2A6sWd/uNei/fupW4zDnX8ihMJ4c9bGpo9l1AUBeEpN3YAa24g381qsXp
         HYz/TdA/AwmyxnQrLJjHhZeZ6p5DoVaqAxyw38wb2IfQZMghTl5oXJF8lEKpmw0qCiwv
         sYS5kLbUnQeKSRPzDg0kbCGsS+Gk8IpxuftxLjesTEY+iYy/SFhuiRla5/oNtGvfGq1u
         Xx88gG8jeb179TZnaDCUkV2vqLd0upVM1CxrNoajB9tDPtqBtyfYuIdYf+YUojCcZcFm
         M+0A==
X-Gm-Message-State: AOJu0Yx4Ee0DDMtgWbtQmYid4SfXgQjD/fASeFGxNcnAo13TVJ/vXGvi
	NR2Ux03deWrtmC+P6Xfly3Ka2PHBSYI=
X-Google-Smtp-Source: AGHT+IFGXqrnOeKqyJ3yCJckvocrKsb0gM30Oxyynn0CiAx4Bp3STF3eSH3RxfQ/qVzdiG+/OksoAg==
X-Received: by 2002:a05:620a:11ba:b0:77f:2d0b:4dbb with SMTP id c26-20020a05620a11ba00b0077f2d0b4dbbmr1382410qkk.32.1701875236570;
        Wed, 06 Dec 2023 07:07:16 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id vy22-20020a05620a491600b0077d66277e9asm11506qkn.116.2023.12.06.07.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 07:07:16 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/9] auto-t: only call set_value for changed values in default()
Date: Wed,  6 Dec 2023 07:07:02 -0800
Message-Id: <20231206150708.2080336-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206150708.2080336-1-prestwoj@gmail.com>
References: <20231206150708.2080336-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default() method was added for convenience but was extending the
test times significantly when the hostapd config was lengthy. This
was because it called set_value for every value regardless if it
had changed. Instead store the current configuration and in default()
only reset values that differ.
---
 autotests/util/hostapd.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index 1b1bc399..cee08092 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -75,6 +75,8 @@ class HostapdCLI(object):
         if self._default_config.get('vendor_elements', None) == None:
             self._default_config['vendor_elements'] = ''
 
+        self._current_config = self._default_config.copy()
+
         if not self.interface:
             raise Exception('config %s not found' % config)
 
@@ -170,6 +172,8 @@ class HostapdCLI(object):
         if self._default_config.get(key, None) == None:
             raise Exception("Untracked setting '%s'! Please set default in hostapd config" % key)
 
+        self._current_config[key] = value
+
         cmd = self.cmdline + ['set', key, value]
         ctx.start_process(cmd).wait()
 
@@ -200,7 +204,10 @@ class HostapdCLI(object):
 
     def default(self):
         for k, v in self._default_config.items():
-            self.set_value(k, v)
+            # Only bother setting the value if it differs
+            if self._current_config[k] != v:
+                self.set_value(k, v)
+                self._current_config[k] = v
 
         self.reload()
 
-- 
2.34.1

