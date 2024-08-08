Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8305513D8A3
	for <iwd@lists.linux.dev>; Thu,  8 Aug 2024 17:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723138965; cv=none; b=LFxUXysKGUp+gtKwPWOQ9O/ypXmrYwvYqCSj+ExlQ8zsH9C/aZu3g7JSthQ4huylNswjr6HfOd7eHPm8vcf+c3Gf5tjLqj+v/k/l+16JUk1iGThT0PdDGYMOtWoQRFGQeXktux+jKDsGPoBsPC35D7/p2IfbB1n7SG3xcVV+hp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723138965; c=relaxed/simple;
	bh=zcfmygZEedhUPgLFVHLHlW3UnxphsOK8lGiRwrln21M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VV04n6CbGScA808cC6WPhaE4/qrA0rZbwHGLTZmWj7ROwrUjNaKCantuZZXWJmR0VF3qSpzogUbxXOm0pCzrA66paJr4pxOlHgAhaXx0cVjE6mW518HxlzYPFLOOoUXpxE0LCWpDqJLAKKuwAccrk9YLCest/ejbUNaGPLMY0eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fp19hPy7; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fp19hPy7"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc566ac769so11114765ad.1
        for <iwd@lists.linux.dev>; Thu, 08 Aug 2024 10:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723138964; x=1723743764; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+7LVb5lYo1Qa0arYhAPcN+vLl04SkUC6WEfVoKbenM=;
        b=fp19hPy736xZ7Nvt+sdSqFRRuirs/xNP0MBjVvfp980uOKrHpSf2D9Mwjy4nob2mdi
         rDql3WkCjeTv/zCrWA2GjHAIH9LjquPxAlDR8biyXJ3IqAWpgS7RAUpIYdEN7MqMtZgz
         FAeWt3GwsesREKwYe8btU4e1JZukLyHAxk8fNLTyp6O+W/DTTTHnwMkRSAAjXK+5QUpQ
         gacW8eRFE8vGtMaHnQC9Od39XfdPhaAiu7vEFiOWp23ZEXB0jin38oih10tQrRi2d6Bt
         Iy4Y2lzQt42o5KeOlxIhbeM2gN2NLii43WX+iAbi9gxNyMPW4632ggHCvws6Il45iWqy
         Ts6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723138964; x=1723743764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+7LVb5lYo1Qa0arYhAPcN+vLl04SkUC6WEfVoKbenM=;
        b=d1EXHpgIJOT4rgCGEcEn39AgMaL2r9YyjEwvTveOE2diqvNGxFRPR7Fnog75rDxY5X
         ojPIS+I0jITF7vwHpcLs2XFHzd5kDcRHKoCseP1cx9Mpq6JaJ5zHw1F7z4M7YJXE92m3
         SxiRB6kSgaoJyzlNQl3tuP3rHb2hVYAMkZdMYcj49Y8LDk280RanfBftlNzW+KY8T2qQ
         kzYHSDrEVSQ1RorhZ9UrtnIArmpDOdkKTjSUBXX95PUlm0DyUfEyUpuvgsOwyQ/LXMqC
         SR6/99t8S8xZvtE8YMwCuvRAlZjxWtItuiPkkWouhLbStxATxCo9sFnzH2UF0M/Sg95e
         kaWQ==
X-Gm-Message-State: AOJu0YyvtEbkIV6jyshEpE1ewcLmPheINeTfnFvUvYx/6TjUmVsMfUFt
	lHBH4Q1yFXdvaBiucK05rhYIchrBdRSLT9RfexDt2XPK26StJmCoAZOzPw==
X-Google-Smtp-Source: AGHT+IFhmdjFoblJ9ZEC/ypXfde725zNxVXaoOAn3lkCvf5nysJGlym1hoCbRkeMxE9J5gi3YNIygA==
X-Received: by 2002:a17:903:2310:b0:1fc:62e5:76da with SMTP id d9443c01a7336-200952b71a9mr32982585ad.21.1723138963345;
        Thu, 08 Aug 2024 10:42:43 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f53435sm127478355ad.64.2024.08.08.10.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 10:42:43 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 06/13] station: add ConnectedAccessPoint property
Date: Thu,  8 Aug 2024 10:42:29 -0700
Message-Id: <20240808174236.218750-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808174236.218750-1-prestwoj@gmail.com>
References: <20240808174236.218750-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This property is a path that corresponds to a BasicServiceSet
object, the one the station is currently connected to.
---
 src/station.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

v2:
 * Renamed ConnectedBss to ConnectedAccessPoint

diff --git a/src/station.c b/src/station.c
index 8a76339c..5524943b 100644
--- a/src/station.c
+++ b/src/station.c
@@ -4376,6 +4376,23 @@ static bool station_property_get_connected_network(struct l_dbus *dbus,
 	return true;
 }
 
+static bool station_property_get_connected_ap(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct station *station = user_data;
+
+	if (!station->connected_network)
+		return false;
+
+	l_dbus_message_builder_append_basic(builder, 'o',
+			network_bss_get_path(station->connected_network,
+						station->connected_bss));
+
+	return true;
+}
+
 static bool station_property_get_scanning(struct l_dbus *dbus,
 					struct l_dbus_message *message,
 					struct l_dbus_message_builder *builder,
@@ -4783,6 +4800,9 @@ static void station_setup_interface(struct l_dbus_interface *interface)
 	l_dbus_interface_property(interface, "ConnectedNetwork", 0, "o",
 					station_property_get_connected_network,
 					NULL);
+	l_dbus_interface_property(interface, "ConnectedAccessPoint", 0, "o",
+					station_property_get_connected_ap,
+					NULL);
 	l_dbus_interface_property(interface, "Scanning", 0, "b",
 					station_property_get_scanning, NULL);
 	l_dbus_interface_property(interface, "State", 0, "s",
-- 
2.34.1

