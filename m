Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BACB4206B
	for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 15:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477592; cv=none; b=p3Rb0ttNszYLXMJ3EJyowufhUsu2Trln2datOZBb+14/bXeeHq4elS4JV2CADEk5IRxClZBpWs5hbiJRWolwE1kQlZuQGiP4TXnDkjRFRSWMrQGalOiy7CdkBl7r3H45/TWoaKpW6Y9rPEaXb+IyUu0Ki3eN7YDo6RbzxNi9iIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477592; c=relaxed/simple;
	bh=GKYQ9EqFStMLgsfyNKnMJ7yGfIXZKKI9kKuDUmwTmDk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EvQFKXY42Wj2H7c8izWB+bMBFyyVcOaIhsw2ii8ewq40Z/DbvCRsxTPLjswQ46jFW5siFPsddmamx9vXixP0Y+61k4EpN6h4VHFjQDPFArEk9+YX7koPlttPeroVgo0zprqX/akWEahgR/rmPVq6HQYeK4L8gtPN64UvzR1Eces=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HExdLHe1; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HExdLHe1"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a10bb7bcd0so5596099a12.3
        for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 08:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723477589; x=1724082389; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObQQmZXcl83AVXC3czdCofeHGePflsvYQ8Cdvz2hw4c=;
        b=HExdLHe1VgD3WuqBSCaDUz1S/7lVEPSNFGVxKQaWqTAmqkl7MBjuyJYnVRm4tlkO9q
         8C7BpVGZDgY4aX6fZDIvvZCRY2mdSj30DVx/HjU8fjIrKck0cN8q+rpSpkAcMoEl15fa
         sO9/9wTQLkRo8uSqPmXcLBdHlAL1ytyWBR79JcdkouQendiqpjKTNRdmuOc3nYrrPbX4
         STk1nvSH6gH1ShGMazJgXWvs804B4SVDXFJ4SrrZ1AfSS0MQPuf2tKiNnE7uLarea+Ja
         oJw0YL1kzjmvjh2nozzJp43T3V6+AVjXIJzT/SWdQaBQyM+JQz7riWuNc8QIegyhTG3T
         lVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723477589; x=1724082389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ObQQmZXcl83AVXC3czdCofeHGePflsvYQ8Cdvz2hw4c=;
        b=YMpAASumLmqlRdBI0+AMkRVjsseCt4O45gMqTO+2xtEc0eHFy2PAMasr7B1uyUjK4O
         UWfulGi3kTzwAwO2saY28eLCAWm1j/fE+8DJlWdDAGYifQEkFvdgn/xESRQE+ybFkEka
         noOifBvjiSCwtPsHE2ZBFV1fi6BSfwHebxRYZTbD9MqtWTGlBw+1DzO9l54Id5D/a4X1
         dI0tLgOXc6tZg0WE9Am2+Qh5XMo6tkLKhtIfkcX593vPPlUSU70simEop93C63ggxZoh
         oVhtynM9/NBf/I656nkr21nwYzJhHB3oV27cpz3xhzKbhL3BywOcxgoJuTothcDrOJxy
         tmJQ==
X-Gm-Message-State: AOJu0Yz5zNWrXANrrqe4x0YeFkBYkNTAjH1pcCGEtg0h7o4QTBI1oDut
	a5uDEWp4sJs9p1yppTggHiDC2AWBwitywA86+grd4JCdh5Qzk+s2rsnvPg==
X-Google-Smtp-Source: AGHT+IErVElMDDXUB2zjQb6gs71PlwgjXOkQ1hUuUQ3UIoXs1gFVFxVljsszMCh0RalIvMfNxf5jow==
X-Received: by 2002:a50:cb8d:0:b0:5a1:c43:82bd with SMTP id 4fb4d7f45d1cf-5bd44c405ecmr403469a12.19.1723477589160;
        Mon, 12 Aug 2024 08:46:29 -0700 (PDT)
Received: from LOCLAP699.vf-sint-niklaas.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd190adb45sm2224931a12.32.2024.08.12.08.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 08:46:28 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 06/13] station: add ConnectedAccessPoint property
Date: Mon, 12 Aug 2024 08:46:06 -0700
Message-Id: <20240812154613.126522-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812154613.126522-1-prestwoj@gmail.com>
References: <20240812154613.126522-1-prestwoj@gmail.com>
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

diff --git a/src/station.c b/src/station.c
index c45b849b..06b19db3 100644
--- a/src/station.c
+++ b/src/station.c
@@ -4386,6 +4386,23 @@ static bool station_property_get_connected_network(struct l_dbus *dbus,
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
@@ -4793,6 +4810,9 @@ static void station_setup_interface(struct l_dbus_interface *interface)
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

