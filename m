Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5CE1448F3
	for <iwd@lists.linux.dev>; Fri, 23 Feb 2024 20:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708718996; cv=none; b=fkK4221+fUzB39XztzB0ONVrloSs8+0QbJk3W6nzHSPoRKAkat5SpYRkHieQElRG0DaVZEi24MFNA+KG5ZItT5Mbn6ytA19fw3rDSQVh+3orWHE6hfjgXjHXE+mBzU1Lk3SAMWV5medSC0vZA0cttSfth35BhQxWcu9IIqFmCUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708718996; c=relaxed/simple;
	bh=aB+1x8kHo0qZHmme1SovSn76FJUNT63KhsYzKbZF5lI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aIbT96wBfGAobiHy5PWP5XLzxQyCi+26zfvDTjWg2hJCFmKzkTnkJy/4MGbiwmBGizNK/345p+PC1g/bQAwhwz3nu3GqLohDPlILWV9YXnpPsXnxyVQywtbRFbZwBt3KI1laIC1g1cuERYT0ji/nKqR6iiU+tkyd/Rb+bK6r8U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=lmARDWIU; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=pX8q9LaX; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="lmARDWIU";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="pX8q9LaX"
Received: from pps.filterd (m0286614.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NF0n9b022144
	for <iwd@lists.linux.dev>; Fri, 23 Feb 2024 12:09:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=kXyQ3T/H2EmORuNE/PYnhMrrc4OBs1jxJd6F9Z8i74o=; b=l
	mARDWIUZ3aKEyEDGrfeC1QTKwLwj4dIEO0wFnNKU3bgC9MIOdNwOxRPvdckg55bD
	Q2mnhlj2V/qo8hFUV+MEcla7QUW0AeWQJYuOGE/hJZRibsymW3QjTxASKnqtLD5l
	tKfka43QsWUBrB/4v958AAvQo5THR4h9Oxh9+P5eQIxt4ORBI1Ejk9aqz9H5KkXX
	/XVQcET5RaIVPwbfX5U9wVc8EkybD0+C1oOay25g3YTvHUxKQ81jPEQh8kGMfGkw
	QkQ2CrfsT1yDRVpdj9a41pNGafosw7ULhbeBs8WnjyormEAJ2jcEqNKlwRArWH/Z
	kR16yuTyXPqaX70+fbwgQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wd565kc20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iwd@lists.linux.dev>; Fri, 23 Feb 2024 12:09:53 -0800 (PST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1dc6e067b22so5607915ad.3
        for <iwd@lists.linux.dev>; Fri, 23 Feb 2024 12:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1708718992; x=1709323792; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kXyQ3T/H2EmORuNE/PYnhMrrc4OBs1jxJd6F9Z8i74o=;
        b=pX8q9LaX+E+q4aXyViGXchL245s2zWCfqOmNHyOJ0Q0cMbsRNIIKoEwfm/SHb6Jl2/
         gSZvrdxrMXS5KP8zJiNItg6/5hCNOq44KJ4fP+2pPamUebJxLzv84HcZmXsJONFAHIW/
         Nm9JxgAMt1OsZwlko44tAB15D0dVO+LVj12+Lbkb4VBM4XmI8hrFlDnUeqDHZ5bN7kox
         PoZP47EhvBVBkWR3oxz+F6DdWMzku2lWd73vU6FFW3AB2Jg7sTOYO4uoNXyuA6KIy8HG
         zrNO2YNkNIPo9LgGOHUgI0VfdoLbsINypttxBCl3r/lb3oHlU/dh57BJ4sTzTfKAuCWe
         mqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708718992; x=1709323792;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kXyQ3T/H2EmORuNE/PYnhMrrc4OBs1jxJd6F9Z8i74o=;
        b=pxRhVkgYvA5ZGDhMJLRSwV315A57dePDxvP6tx08I/VTSx52BpsAyehVrNfRxfQoza
         p9DQS31Cgurj1XicBmRirzAhi7ApyWCbddO8AFRcJG5UEm4tiIHUkI2koGgpJWCHjnIO
         cWMPfoq40sP2TWEminh3rjEZeY4AJQ9QTNaYHDYCgj5ft1a3QVXX08i+zO6DmKLhWTyP
         Vki651TJJmA6fkGDMtDxnAfxmSJQoW5aoyXC+rK15sF5NM+UlaL8I7SL8ndtobvvFiIM
         a7PCjegCbMvmcbth7GhMpwEuaoOlLSQOkM5kbxRVdJgKVLZeW9DhI7T1qUgzrItkHrD5
         ntwQ==
X-Gm-Message-State: AOJu0YzyzZYzzndH3CUF5nXyPHW2X41Cn5NslL7fYGXTP9HZlXsvP1bT
	Hu/Eegl5YXyQzf6M4FxxGWPmbHNbcVCSoHeP9rEoKkFkQkFc4LDmnmZ/AAh73bRPHMa5ID+eHCN
	sE6nNNph42x8z0XmHuXJap6vZjphN06yQoMA/jd8u0SihBM5IncYjFMkhEsqe327U1YxT6UZF+2
	5N/8m42GPCqq09pcm70Z7V6Ywobtls/zMM5m/mjtjw4rSWgpQ=
X-Received: by 2002:a17:902:d491:b0:1db:e78e:b395 with SMTP id c17-20020a170902d49100b001dbe78eb395mr1029185plg.34.1708718992420;
        Fri, 23 Feb 2024 12:09:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsbEYjAsHxGFRySEaGJTrGgxlinJuaGaHR7K/SMQXxnrx4rrVY8YX5L7eJci1Bw2Q4L2589Q==
X-Received: by 2002:a17:902:d491:b0:1db:e78e:b395 with SMTP id c17-20020a170902d49100b001dbe78eb395mr1029165plg.34.1708718992062;
        Fri, 23 Feb 2024 12:09:52 -0800 (PST)
Received: from BPHKDV2-DT.corp.robot.car ([199.73.127.2])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902ed1100b001dba356b96esm12019730pld.306.2024.02.23.12.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 12:09:51 -0800 (PST)
From: Ram Subramanian <ram.subramanian@getcruise.com>
To: iwd@lists.linux.dev
Cc: Ram Subramanian <ram.subramanian@getcruise.com>
Subject: [PATCH v2 1/3] station: add channel number to diagnostics message
Date: Fri, 23 Feb 2024 12:09:07 -0800
Message-ID: <20240223200944.1343893-1-ram.subramanian@getcruise.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: Ykr3QgCPYPeQbPji4DrZdykXi8_qxyEC
X-Proofpoint-ORIG-GUID: Ykr3QgCPYPeQbPji4DrZdykXi8_qxyEC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230149

As a small convenience to the user.
---
 src/station.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/station.c b/src/station.c
index ea505ca2..33b1f5e8 100644
--- a/src/station.c
+++ b/src/station.c
@@ -4702,12 +4702,16 @@ static void station_get_diagnostic_cb(
 	struct l_dbus_message *reply;
 	struct l_dbus_message_builder *builder;
 	struct handshake_state *hs = netdev_get_handshake(station->netdev);
+	uint16_t channel_num;
 
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
+		dbus_append_dict_basic(builder, "Channel", 'q', &channel_num);
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
