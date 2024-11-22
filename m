Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FBC1DF97C
	for <iwd@lists.linux.dev>; Fri, 22 Nov 2024 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288564; cv=none; b=QXnMeeCT8IAYLoJ8eCQMlwWbQiiLLpk+2Vx0CAiB2+bEBU1Oc2gs3RJOuKSArHUI+CLq0y95bJG80emzlKIYRqVAFpT7ezlighwQK7jKjQshV7xhgxWxI32vaSa2hH/VQIzwaQ6ft2j9K//CUPy+AB9UcQ8NnQ/m4yjPOjfOxBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288564; c=relaxed/simple;
	bh=lz42EzFJGWQ8+rQb+j+gOzZplkzxcGWyNyolwtaV3kA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZGQ++ejN52axqnzJxAA9it0Yyv/27/RaWgrXuIzSi1ahI72twv5Gh+6ZL4WoCTHO+7nRZiUGWixIHvaCv0kOp25vaP3bZDaEPiuQCn47uKqiL3+w9n8MCNsyTBg13jAYJ8hBYnFqmq1QbyFG15DkXnc0pnkmF3rHBlhnIIEpVz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7oaKcsA; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7oaKcsA"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b15d7b7a32so143370385a.1
        for <iwd@lists.linux.dev>; Fri, 22 Nov 2024 07:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732288561; x=1732893361; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aeqantfww0CyY6LtbLG/AePT/EJjBBFmJzhCfNYHwDA=;
        b=R7oaKcsA+2P7qhpCJ+nV8zf9tOMn+u3aTCDrgar2e9dB4Amf/p+NvNCxVYWhZmvV4C
         f1zHBPKOa/Hcop6VGofAi7FkjwLcrA5iggVacI/KS2Zw2tP98W72yUPRb1Ql9iuJNNA3
         BYmnDhVOjZMdsGUk/+qTLR5Yv04zZy1RMP+7ndr4WN3tPHy72CIkMRWsVPVM4JOHVLjG
         gEtVTs53QAiJ6guXG0R+/Trl1FwcJCvJvgz81Fyhxh8mildK4cpGcSEwna/SrtVpbADV
         s0FF8Yp3XLt0Hzmv2An6U5jWSn7Ks0O79yYpYVqbW7r0ExlG4nqLWh/4s8UerXH5Rz3V
         GadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732288561; x=1732893361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aeqantfww0CyY6LtbLG/AePT/EJjBBFmJzhCfNYHwDA=;
        b=HIUAinV97atZSSA0HqBXYeZ+p8EH1VS+iweQc2VZTJ6kPkzdzF6u1JheRDSnxK/r9Q
         L6wDDAv1mStWXlpwqOM8LZopiLVynN4YfVPAlNTx3M9OxpWoeAUk4sxtAqDlFLZTVPBO
         /yr9+hiOAhNCSYwnG1IG7sWK6DdcOtkE7ej0QZZVFFgbV5dHXJOWwSwwd5TzP4DKMM5S
         /BoRzfAgC8MHOVE421POt6ofF+/5bMqZP8iBmbIAPdzXcqevDT/QRYd+WisD28p87J14
         zCsRbZoO/HAbkOByBmGF8tEiC/iCzY19DED/G+TZXuFq1tZYPDWdjEb8N1KyB2EtCMII
         YD0w==
X-Gm-Message-State: AOJu0Yyq6/iFv0nwn9bCQv0RoBfyp7jBVK6RjJ13Glq+AbELlhtr1pta
	hZjyTPfbAT29CQzpYZwZVKZ8SIMzysuzehWvW7ndwlRRFU2SVOEKlOFZ3A==
X-Gm-Gg: ASbGnctubjLtM2I3YhpeB+yQKDTj23osrRZj2/ex3mmiq3GrDEhxF6W4CXDLFanrZ7t
	Gx5q6lKc0Ay7tDorUkD+Fi4pLNGWd9K9uJ2b3HnpuNDAJU+R+AFIhUiAQtpdbEIpOZSDeQa7cbn
	IsM2Vtij7vYwjrQjdYEzX2dtdZT3qh1xx4sjTXXfp1Jynp2fUFCsLp9FPwaeVMtCvKPXK5yCNFG
	MWXeNKs0bmsulXkSkn2R98PgsnIbgz/67mbH/JRaFq+wFZ4QRjRafRv0OPd
X-Google-Smtp-Source: AGHT+IFQfeFXhHxwV2bRxqSx+juZZ4Rdrz6QFNGGdV+ohlAd/3w1p3uny/NvDu/y5aNJrSI95wmkGA==
X-Received: by 2002:a05:6214:20ea:b0:6d4:76a:d96a with SMTP id 6a1803df08f44-6d451393387mr40205276d6.48.1732288561237;
        Fri, 22 Nov 2024 07:16:01 -0800 (PST)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a9a720sm10722706d6.50.2024.11.22.07.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 07:16:00 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 03/15] auto-t: always initialize StationDebug in Device class
Date: Fri, 22 Nov 2024 07:15:39 -0800
Message-Id: <20241122151551.286355-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122151551.286355-1-prestwoj@gmail.com>
References: <20241122151551.286355-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since IWD doesn't utilize DBus signals in "normal" operations its
fine to lazy initialize any of the DBus interfaces since properties
can be obtained as needed with Get/GetAll.

For test-runner though StationDebug uses signals for debug events
and until the StationDebug class is initialized (via a method call
or property access) all signals will be lost. Fix this by always
initializing the StationDebug interface when a Device class is
initialized.
---
 autotests/util/iwd.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index e9101d75..9091807a 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -450,13 +450,15 @@ class Device(IWDDBusAbstract):
         self._wps_manager_if = None
         self._station_if = None
         self._station_props = None
-        self._station_debug_obj = None
         self._dpp_obj = None
         self._sc_dpp_obj = None
         self._ap_obj = None
 
         IWDDBusAbstract.__init__(self, *args, **kwargs)
 
+        self._station_debug_obj = StationDebug(object_path=self._object_path,
+                                                    namespace=self._namespace)
+
     @property
     def _wps_manager(self):
         if self._wps_manager_if is None:
-- 
2.34.1

