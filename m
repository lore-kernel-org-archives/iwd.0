Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECA13CE4B1
	for <iwd@lists.linux.dev>; Thu,  9 Jul 2026 21:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783633558; cv=none; b=IYUZvmaComlWvZWAmRfVULZLLU1G7hE8DkQn7NlVMhFrWkSji+m8+gmR5hbVBWybYafvqbfbiLARwqbFLqiChw80HrCWAumNCrnxBdM7UEcz5WBREIYKN1386tyBN6QB7ybjDiC2b+2qjfsbha4HxZxXkATVPjpnRH2LH/BklQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783633558; c=relaxed/simple;
	bh=1oBnexf04aoCn/E7XLzFcGjIGqCVffMRZiNr/wJsdig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MKcF8uw8H5sjZMCo2hL+yjHtQUtRGFQu3/vlW8a5oXrugqOqIQnVIzarvmikG61ZUeNs1z5JNf8P3tUTTkR5mZnPWFMX91VuaVNyygZQ+yXlQAI4AW/vGmP7UWb7N0VHOoQPfi5yxtXaQ0Qg/SGY/HFk0kWmHUoPs3X3/CPU9zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4w/XcX1; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4w/XcX1"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c1805b8a7so2543801cf.3
        for <iwd@lists.linux.dev>; Thu, 09 Jul 2026 14:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783633556; x=1784238356; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RAt6InrtSFjUxRiXYn/KOEfVyku0b3YKMlQajFHIuXI=;
        b=S4w/XcX1WD1vnyxJWon0gAlzbhoaWQNqFSvQ7Ui7F5pXpSXaT6/ZbYteSGLtaKWDI4
         DuO+LNheLfBn5RmRdr//f/Zd2IZbk9asufcqGNBa0Q7w9P1tTmzS2SJTza09pKbmKl7B
         kXMWawhlkLmNMZh9Xp862HbVPNPJCzpw6uFL9PSRNK8cb9yxKPr0DbQnjBpWhrlSM8Bl
         ZSaCu4i85U4oats5mbGox7IvbCLEPGbOiOYLR7dnSQOc5oo36mgKeSTe3p06WdJDJbL+
         IMMHPJQlBXrBq4RPT+xFsQlTgUU4ucZHDR9QdgQ1x3XeBYUoXR8JV8KCA1IR4jhbMYx1
         IqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783633556; x=1784238356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RAt6InrtSFjUxRiXYn/KOEfVyku0b3YKMlQajFHIuXI=;
        b=EoBER93Ce5VEMlx+GM3okTTh8cN4/icfMxmCmQbAj+MmEnpBhCbnEWREf9Bt8bGRC4
         Fd+mnpbDWpgXuV3k139ZIbeeBUmAFWb5YEo+WOzmpeQemuZmg8jToyvPJNONAUto0EM2
         QtE6xtJTU48fOdGMG28KSMUeesQxpoe0Sf/vSmsdML6Wac2C1MNRgeEhwzaxadfs2XS4
         9KcgC9HoLycfQvcXetTpYHeqVa68KQL/U745OeSmffq9v8kgZUOq5T1Eo/TULvcvoYP2
         GkNaNFr9QwUhyepYqNQRgQZXyBE6uvKndlFZ5CWNj4jpsxplcrokobCO9apnTwb6h7x8
         87MA==
X-Gm-Message-State: AOJu0YyLYU+MlxKG7AJMIZpoIbZEmQGUNFb8NuwuQMJrRkWC1rOmAxaM
	a1jMblo0Ne40thtXraMUZ57W46rFurWIakQnznMPbhoYYEWiWcqpbpc/xZEtTw==
X-Gm-Gg: AfdE7ckKuIMkfGvDw46VdoOnfz/Co0Fpc1vH7K/tmhC40oR9bhffQctMKZf2qM/hqcO
	wNTaDrvTfj2Up+9H3XitL5Z3go7Zbfchb0Eg89oJcuHW4j8yU5bhqpSqOqHya7AaUjTIB1yATiE
	DqP57PLrAb6Iq4oIBnVZFUazfebVXsWGXhN7E4deMZUMRCqkzvJV4jQa+maTc6ynmESzRqI2s20
	AG5yLaxkraSXw6zuLedh1NNEk2OcE2qsUBnkUim5aARq5DJC9WRGaHaYQVhbOzfXNDMHH+7lncP
	xa7PGE20AK/PBagmMU+h6x2iLscuPde7K6/itKEJsDRy3+0STbfMiGL1TIOJb8WSz8Z2KQGbE7p
	aw6u0PmlsIwVrSpxS4Onn8D3/tIrqkBc5EZJAdp5LAiq8SzBYkzak476YKCMU9zG5Pi3xDaLble
	LIS1ppfrKy99urSmYTzXlu4WV4YTXLOYi+0bzNIU7r0KsSG269W1+7F7WvKjQ7SsCaGetOL/BHK
	eAgu4g=
X-Received: by 2002:ac8:59c7:0:b0:51b:ee11:e71e with SMTP id d75a77b69052e-51c8b2af948mr98367921cf.1.1783633556409;
        Thu, 09 Jul 2026 14:45:56 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caab6d574sm3857641cf.3.2026.07.09.14.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 14:45:55 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] doc: Document new station diagnostic values.
Date: Thu,  9 Jul 2026 14:45:46 -0700
Message-Id: <20260709214546.659971-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709214546.659971-1-prestwoj@gmail.com>
References: <20260709214546.659971-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

(BssLastSeen, ChannelUtilization, and SignalNoiseRatio)
---
 doc/station-diagnostic-api.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/doc/station-diagnostic-api.txt b/doc/station-diagnostic-api.txt
index 9b51d4b7..a946682e 100644
--- a/doc/station-diagnostic-api.txt
+++ b/doc/station-diagnostic-api.txt
@@ -27,6 +27,9 @@ Methods		dict GetDiagnostics()
 
 			Security - The chosen security for the connection.
 
+			BssLastSeen - The time in seconds since the BSS was seen
+				in a scan.
+
 			RSSI [optional] - The RSSI of the currently connected BSS.
 
 			AverageRSSI [optional] - Average RSSI of currently connected BSS.
@@ -59,6 +62,19 @@ Methods		dict GetDiagnostics()
 			ConnectedTime [optional] - Time Duration (in s) for which this STA
 						   remains connected to the BSS.
 
+			ChannelUtilization [optional] - The channel utilization
+				advertised by the BSS load element in scans.
+				Note the confidence of this value heavily
+				depends on the BssLastSeen time as this only
+				updates when IWD scans.
+
+			SignalNoiseRatio [optional] - The signal to noise ratio
+				(SNR) received on the last scan.
+				Note the confidence of this value heavily
+				depends on the BssLastSeen time as this only
+				updates when IWD scans.
+
+
 			Possible errors: net.connman.iwd.Busy
 					 net.connman.iwd.Failed
 					 net.connman.iwd.NotConnected
-- 
2.34.1

