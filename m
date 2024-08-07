Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63FA13E3F6
	for <iwd@lists.linux.dev>; Wed,  7 Aug 2024 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054486; cv=none; b=W3y92d+mTsTF4mxj7kEQEcPXICqb7Aj/zLlsIVl0NPQPKRZT7eeADlFJlL53fppdirqidyrKTNztsqtNcFFlhxiAz05cEiigohoVAMX6jR3UEuVR7n/J5MSXPVC8Y6jMLfySsvzGk5bBKbk6fJWU+1r3IopTWQHEC50AWZp9rhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054486; c=relaxed/simple;
	bh=0JXQUsU+CeZbduEPiJJveo0hTbm5nD6K/zdc+wnogXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L22IXiKNVHf2/kTLubf7HuJykE74R9Rhak0qDRAHbG6XcmjuFOBjpJjduiLt2+foachwvjzYc7Dt0s56VRofygNaZwVMA5W70X9G0r080YVaYIZaAWfzepNfNf73ZM7V4UapMTc6teB7sU+7eSIgmJlFDk+K81mr7zcOJQdS3FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8ydoxV8; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8ydoxV8"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a1dcba8142so88904085a.0
        for <iwd@lists.linux.dev>; Wed, 07 Aug 2024 11:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723054483; x=1723659283; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkZzKtxYPZkT6hUlkqBEznSewHrv3kJaBT71xggLwjM=;
        b=X8ydoxV8T8sCNnR8jiflZZPMxwUw+ZPFnIxX8IxgqmSmuVsPSXd2sgEPxZFS5NwEBU
         G7RNh97Uwp6KWLv7ps11DllFrAbxB/VibWkRnCmVyfjWH12FYaOLG8/4Ife7PdNwzs0M
         XU6ABSUWvArqYybOrFixDy02tGoPhDkVUVDJIfbj9VSV2kpGP7DLSGvC4Udn3G0czIlc
         DgyGlg6oIhCgKF0UKGS2oyXucdc93EsQPpo7HIcs/ALd+LyTK1vuuL3JdJZ06vHE+QEV
         uypSYEtD26Gg3FtieBqe4xu/BuQ030wRigRYxE57gfI7CUe2uVXEvJlujszp/8IiYC3w
         9Otg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723054483; x=1723659283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkZzKtxYPZkT6hUlkqBEznSewHrv3kJaBT71xggLwjM=;
        b=MFwDE50pnAKnVbNqfUJu0eJekIluxZq0szkF6KfRhU8r8iK4E0UDScij4oXYgcyh6Z
         RO2+o4iZ4splsLO7xd4w9XpE2rxSooDFQqkaP+reqoqOUy1BpPgUSXr2z1VJ/XNNGT5O
         Ak+zWtcRa7Jg/ZabsDo6yCwTvYXmjxL+8hoAzZGHN/po1NA8Tvlh5GOYca35LwQm+ykV
         AIroy6TYEK/a85b80dl89z17ld6nibj9zpz2mhSmfizHtO1G13kp5QWtSWTcl84vScla
         1R/m6WYzv6MCIpbMFJenHyaTrmZcR0eubu66t/AGcqCAZKPquBPp6tdPipDhn6JBuHGX
         F8lA==
X-Gm-Message-State: AOJu0YwgUgNBU5Ybjng7yTEdfey2LeY6C98r/TK7ygR2NvFj9nvHmosp
	pMeMufsD/zbFTv371QT34DVPGrvibKYaUoLpceEVeTqoliF1gj/BOzfiAA==
X-Google-Smtp-Source: AGHT+IF/TpqGpCNlpJaemJ3pfO/08MILSQYwqOUE3nUERqe79Fx+GMIInqLCNxsuM5MFRCzAmK10Iw==
X-Received: by 2002:a05:620a:4113:b0:79e:f878:7ffb with SMTP id af79cd13be357-7a377c0dbc5mr597787585a.9.1723054483442;
        Wed, 07 Aug 2024 11:14:43 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785d0db4sm82194685a.7.2024.08.07.11.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 11:14:43 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 09/14] client: separate property header and values into two functions
Date: Wed,  7 Aug 2024 11:14:22 -0700
Message-Id: <20240807181427.170515-9-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807181427.170515-1-prestwoj@gmail.com>
References: <20240807181427.170515-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are certain cases where we may not want to display the entire
header for a given set of properties. For example displaying a list
of proxy interfaces. Add finer control by separating out the header
and the prop/value display into two functions.
---
 client/dbus-proxy.c | 38 +++++++++++++++++++++++++++++---------
 client/dbus-proxy.h |  7 +++++++
 2 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/client/dbus-proxy.c b/client/dbus-proxy.c
index 42b8427f..1e50d902 100644
--- a/client/dbus-proxy.c
+++ b/client/dbus-proxy.c
@@ -47,10 +47,10 @@ static struct l_dbus *dbus;
 static struct l_queue *proxy_interfaces;
 static struct l_queue *proxy_interface_types;
 
-void proxy_properties_display(const struct proxy_interface *proxy,
-				const char *caption, const char *margin,
-				unsigned int name_column_width,
-				unsigned int value_column_width)
+void proxy_properties_display_inline(const struct proxy_interface *proxy,
+					const char *margin,
+					unsigned int name_column_width,
+					unsigned int value_column_width)
 {
 	const void *data;
 	const struct proxy_interface_property *properties;
@@ -59,11 +59,6 @@ void proxy_properties_display(const struct proxy_interface *proxy,
 	if (!proxy->type->properties)
 		return;
 
-	display_table_header(caption, "%s%-*s  %-*s  %-*s", margin,
-				8, "Settable",
-				name_column_width, "Property",
-				value_column_width, "Value");
-
 	data = proxy_interface_get_data(proxy);
 	properties = proxy->type->properties;
 
@@ -82,6 +77,31 @@ void proxy_properties_display(const struct proxy_interface *proxy,
 	}
 }
 
+void proxy_properties_display_header(const char *caption, const char *margin,
+					unsigned int name_column_width,
+					unsigned int value_column_width)
+{
+	display_table_header(caption, "%s%-*s  %-*s  %-*s", margin,
+				8, "Settable",
+				name_column_width, "Property",
+				value_column_width, "Value");
+}
+
+void proxy_properties_display(const struct proxy_interface *proxy,
+				const char *caption, const char *margin,
+				unsigned int name_column_width,
+				unsigned int value_column_width)
+{
+	if (!proxy->type->properties)
+		return;
+
+	proxy_properties_display_header(caption, margin, name_column_width,
+					value_column_width);
+
+	proxy_properties_display_inline(proxy, margin, name_column_width,
+					value_column_width);
+}
+
 static const void *proxy_interface_property_tostr(
 					const struct proxy_interface *proxy,
 					const char *name)
diff --git a/client/dbus-proxy.h b/client/dbus-proxy.h
index 98b0a2a4..f0a5d38a 100644
--- a/client/dbus-proxy.h
+++ b/client/dbus-proxy.h
@@ -95,6 +95,13 @@ void proxy_properties_display(const struct proxy_interface *proxy,
 				const char *caption, const char *margin,
 				unsigned int name_column_width,
 				unsigned int value_column_width);
+void proxy_properties_display_inline(const struct proxy_interface *proxy,
+					const char *margin,
+					unsigned int name_column_width,
+					unsigned int value_column_width);
+void proxy_properties_display_header(const char *caption, const char *margin,
+					unsigned int name_column_width,
+					unsigned int value_column_width);
 
 char *proxy_property_str_completion(const struct proxy_interface_type *type,
 					proxy_property_match_func_t function,
-- 
2.34.1

