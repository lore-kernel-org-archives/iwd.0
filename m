Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0528C127B57
	for <iwd@lists.linux.dev>; Wed, 21 Feb 2024 21:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708552009; cv=none; b=XfbP7XKbIuzsmK4lV0mLe23r+xZADhIkI1i3rgi7ULxUsfZBOF8/KHHJw0U2+MjRiF7Lqdtdq+lzvywBLt1frtJD7yByXo2PG37AoTcOoOykYaU+H35mTvVfPpelrX7ml/39COs323pdovy/kwwb01uXZXQ+sSdAxYYsPMkj5hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708552009; c=relaxed/simple;
	bh=vaDE3ISx8/ejgaWTn4ndhDWUy0S2Ba7ol1t2zXwYFgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G6kOXpne8ZOZCBb8jN+HfxhL5zgznyILih8PtGfg++psG8RCchAF90qCyHmeUYoJ+W34FbcYuJ7jpszFKtoUoMfMIS3SIYzfJd6UfIoqIlJfujjqMVYmjFkGEO+CKxsV2209sAasWe9m6SO4ZNHtIspYE2sy96xs6zfIupQ5dPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=gFJ4x49y; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=jUDfO1rw; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="gFJ4x49y";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="jUDfO1rw"
Received: from pps.filterd (m0286616.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LEtiV6010491
	for <iwd@lists.linux.dev>; Wed, 21 Feb 2024 13:46:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=vwTSk73Szid10PuMoKmQ8mJ1Su2teHCdFcm+7d6+c30=; b=g
	FJ4x49yT2wqpQ2Zj8Vh/uspCZbB8Dk/k/ildwLE18hweEfbc7mJHNri3oFZdGwNy
	xTNyrey95wxlhZcJI8OFoDpvc2g0UIbK4cEPNAqwQtQ9fu/qMiUSiDSLsND0tPqd
	ycHk57L1lFWyKizw/yJ7HXqfBOs8xqLDB2PKemAM/+g6RXV2H8L3idzHzwABcgeW
	AoEhMOocpj4DNMhFoMWbS1gN4IfXbThzE5CKFo9DWvmOFR9wrVW/WXaDC3E/atXI
	r+hYCIpt+Ak8UIU6abtod+1aHjga5/OjJ5fhZRnXqCF+0uFzaDLvRdeQJVE28HjI
	hzUmJ9ItQf4vuN/Z96AIw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wd564s1jq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iwd@lists.linux.dev>; Wed, 21 Feb 2024 13:46:47 -0800 (PST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1dbcea09f64so38030685ad.3
        for <iwd@lists.linux.dev>; Wed, 21 Feb 2024 13:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1708551990; x=1709156790; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vwTSk73Szid10PuMoKmQ8mJ1Su2teHCdFcm+7d6+c30=;
        b=jUDfO1rwzfGw5DEbn5C2Mw3osqWkevY1hCc0afx1Cvwrh2PjkjXgwCLXF7vMTBvdRX
         06u5ew+l8iqtqkvr+q+BpVI0tVG6e1163seKTkRs4RqNRmMiePYXjTA4AWrCGYP8vSDp
         rn+ClCOPB14uPf5p9ZUrsmA1x1Kmp8ncgMoeww89PBaEHM9xT+VW8QYQI/jDCVqUibuR
         xFjQArqYygxtcQ9oZnV3u2I21rjsRmaCWXK70sFLqw6EuS+hPtuu9V/ehnPFaMEJik9s
         qUOrgRaBlgHimjk4PJfbrqjXLRL9OiNiSsvc1SDyithOMnWGiobckxFRwAsPG+CaIA3p
         eVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708551990; x=1709156790;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vwTSk73Szid10PuMoKmQ8mJ1Su2teHCdFcm+7d6+c30=;
        b=gqRr3oxvzBATfSpgFc/lesyJpJT5rJ0eCbzP1NYArFrUJpgOejZyl9c82ZaVlmN4Rj
         oelwhiMJ0TXCxnqmFVi2RJMuQXLZBCow2fwlZHHka1t+M6Zfw63llvQPklMKyZrUPvEm
         fh4j2ik6bihuY/jlgl+8Ruak4h5Evp3H04aD96y8NFYRYiD7rtpQoftI5Qq6c88NELwj
         jh8Gr9vwOc7al7dmkcMDJWdtSAl3qk+xx8sYb4ANNkozoKxLb/QkrEa/3eM6R/3PluLo
         YKtOmIGY4eWdYy431RS7yBJOxYt03KIqkCCmlGW+Z6MJ5so6Aj39WfxUKkLSvzuAX12t
         75zQ==
X-Gm-Message-State: AOJu0Yxi5S6Qooo7Br8wYDaFP/w1RrixMx3TYXiSzm8hdRdsuxeJxbj0
	nl9sF83NnVvJZXIDrwMiLu2JHtHUJ7bVKzXyn5bL2MajCR7yKHhFJ8tKprZ0T25hor4W/h3kYyu
	W+jUFeXj2g3J+TOkvgt/KtyHIjYPJnj18F/Ec6TJbb0Q6DCCMIXSzygRNORfaM5NawVPK+QteAk
	OkdPNHDxrVXts6hb8zEp5ASeOUkmOsRO/AIBJJYVDuKmY8+Bw=
X-Received: by 2002:a17:902:7b90:b0:1db:e7dc:3031 with SMTP id w16-20020a1709027b9000b001dbe7dc3031mr9405241pll.2.1708551989813;
        Wed, 21 Feb 2024 13:46:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOPPquPvXy+Kde9S4xf3appcP+1+3B+yvyETvp5weVNYzhPosTKNs7O1Eg/fztuEr2HluD9A==
X-Received: by 2002:a17:902:7b90:b0:1db:e7dc:3031 with SMTP id w16-20020a1709027b9000b001dbe7dc3031mr9405223pll.2.1708551989427;
        Wed, 21 Feb 2024 13:46:29 -0800 (PST)
Received: from BPHKDV2-DT.corp.robot.car ([199.73.127.2])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902b78200b001d7137acad9sm8541955pls.57.2024.02.21.13.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 13:46:29 -0800 (PST)
From: Ram Subramanian <ram.subramanian@getcruise.com>
To: iwd@lists.linux.dev
Cc: Ram Subramanian <ram.subramanian@getcruise.com>
Subject: [PATCH 1/3] station: add channel number to diagnostics message
Date: Wed, 21 Feb 2024 13:46:22 -0800
Message-ID: <20240221214624.601337-1-ram.subramanian@getcruise.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-ORIG-GUID: Jb-Xh5Y9r37_ZaYlbYQEz-K3pFz1q6WR
X-Proofpoint-GUID: Jb-Xh5Y9r37_ZaYlbYQEz-K3pFz1q6WR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_09,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402210171

As a small convenience to the user.
---
 src/station.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/station.c b/src/station.c
index ea505ca2..39b98037 100644
--- a/src/station.c
+++ b/src/station.c
@@ -4702,12 +4702,16 @@ static void station_get_diagnostic_cb(
 	struct l_dbus_message *reply;
 	struct l_dbus_message_builder *builder;
 	struct handshake_state *hs = netdev_get_handshake(station->netdev);
+	uint8_t channel_num;
 
 	if (!info) {
 		reply = dbus_error_aborted(station->get_station_pending);
 		goto done;
 	}
 
+	channel_num = band_freq_to_channel(station->connected_bss->frequency,
+						NULL);
+
 	reply = l_dbus_message_new_method_return(station->get_station_pending);
 
 	builder = l_dbus_message_builder_new(reply);
@@ -4718,6 +4722,10 @@ static void station_get_diagnostic_cb(
 					util_address_to_string(info->addr));
 	dbus_append_dict_basic(builder, "Frequency", 'u',
 				&station->connected_bss->frequency);
+
+	if (channel_num != 0)
+		dbus_append_dict_basic(builder, "Channel", 'y', &channel_num);
+
 	dbus_append_dict_basic(builder, "Security", 's',
 				diagnostic_akm_suite_to_security(hs->akm_suite,
 								hs->wpa_ie));
-- 
2.43.2


-- 


*Confidentiality Note:* We care about protecting our proprietary 
information, confidential material, and trade secrets. This message may 
contain some or all of those things. Cruise will suffer material harm if 
anyone other than the intended recipient disseminates or takes any action 
based on this message. If you have received this message (including any 
attachments) in error, please delete it immediately and notify the sender 
promptly.
