Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231271F176
	for <iwd@lists.linux.dev>; Fri, 23 Feb 2024 20:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708718997; cv=none; b=BjhH2Nbat+6ZQ8IXC08hWh9Io4nMWIEgYir5x3yFg1JNz3sKXppYMxTABjGatc4Eet6GrNc5lIJKduN47cDXzXlofecPMRpgeU0YKVk4wzF3+1GIztNQS/yWrA2H5QoghHt/vSo3JZ8O6eKutvHAUoxoNfV0mZ9AaVsV2h1cCt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708718997; c=relaxed/simple;
	bh=YMwlKu5pcV9IgkHBa7BXpVmtVFGijQkB/LQp8Qlai8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c2Mzoe/3vwkhsgP82t6RjXDqpz01CFmetd7iQU3TRVXynmigKjF5wJJTQiRsyIq5M8usVSzRKjS7heflO8RyDraNt1jrhh3Wu3qnkyVWCnzMPmtyGhDomxjb4MtUFD9T0HRm4TxJUvLwG2KnC0v9ZjgY2g7aVG+KtW6c2Tla4oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=YSYXEvOe; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=jmpGV//A; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="YSYXEvOe";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="jmpGV//A"
Received: from pps.filterd (m0286614.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NFpkZT004935
	for <iwd@lists.linux.dev>; Fri, 23 Feb 2024 12:09:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=F0iLyfDmPkZBlAoxsLIy2q
	xBHslPYa/SqcNUwB0Ys3M=; b=YSYXEvOeHQO3bNn5vZqAa77XMYugPxhcXKjQBM
	f0+dzk9Lz4AJA1wEQKv5RdOZjRrzrpP4I4ita0TOIHqLQKeRJO7kSU7saaSlomtJ
	BIte40rghYwxZ2XMNQXhpYei3l7UB65c0+tyNmiOKcAVREPD1rbSRV/ljR/FvaYw
	XQBAwQoFLoGpfWGS1XdycxMW/45g/XLGUR7eGW3xuW/zBTF7qpud5mfy/VyhFUrc
	98LBAL7tTay3syBJLeCt9BppzqsKBzScwgwmAkBVXHr/SEkuGwwSZSgU2MW/U63M
	uECfGdgg8TTQeSvpJCkFZ3E/VXD0g/hplcG7E1ixGtyJrSrg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wd565kc23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iwd@lists.linux.dev>; Fri, 23 Feb 2024 12:09:55 -0800 (PST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1dbcbfff988so13090835ad.1
        for <iwd@lists.linux.dev>; Fri, 23 Feb 2024 12:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1708718994; x=1709323794; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=F0iLyfDmPkZBlAoxsLIy2qxBHslPYa/SqcNUwB0Ys3M=;
        b=jmpGV//Ab1FUHMiN5/iZNR2er66TU5t5/PNSuxNiwzBWeJ/KF4nX1K4zGQgUaaQzba
         04Md/r5k7BCTtra2uQzWRzcqiIA6MqqHmKNPk78mM6t5MhUuaJw7S4MfSxCyT0qrgnvi
         gFNExTolDKyhHPWXpj4cjUcLJ5xgFb//cqzcJooVpaKV4SDLX1hjGbFazQdpHqD/VOiT
         V6KZ1daXbqYEK2i5I9PiJD2y/hwj2fSPXtYZ7RTd/GmEjwQXbtkqUxWVNXFClf4uBrjp
         bad2oGOpU3DyW9TtjXvt4xUHhRxTn1VHGtOuEdAF93AHXRRVeIz3jrUey8AqeYSxCBYr
         tniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708718994; x=1709323794;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F0iLyfDmPkZBlAoxsLIy2qxBHslPYa/SqcNUwB0Ys3M=;
        b=j4thazj5fa8ImfS817LQdjaw8ocyZ99OzXFx2C3na+tl2LwOlnR+7lh4HHqCdf2Phb
         gCihkBEZkUDYGDrbr68+rV+Nzm3E5jHDKB1d6yY48IimpWH3ynBw3MqNOQkFrv9nLa+V
         DH4yEJ3kpphu/nXqgWyyy/Dh/h4BCXECUzmZKw0DkNE7XT1diw2g8NNBrFjqUupKotUi
         9K/69y//WN9avLKp53SSN63z8a6hZBMrDfXiQ3Gp2Iqy3gy/QaQbLwaeyIb/XyL30jw2
         9dGfOk1fnFXLo86foO9Zed9i6PqNtLe4v1PBcMvmYUUyEfb96+1nN8Pmtu6eqJescZiN
         4ZFw==
X-Gm-Message-State: AOJu0Yw0ULTXJHrnesxEHckqSiFLf6NjtsixADMze10Kb1WfBdLkU6bN
	sMXHQttyKo/H/IoKChB2h+Ntsk1GyW2eFgLOsSfSMmLw6ecKmGnWbDSomcIwxpl23EFWGGjpRye
	bXBCOZeklTBon0B7USc8gzMFxfnGuJliDw7F5GXPSo9j9yMVEoPMG1FaIkoY/H3ZGhHHlLsyEAw
	3SEfmhLjWp+/J8Hm4kSONSZIR9AG1sMNVKNR/guhb+lMp9hAk=
X-Received: by 2002:a17:902:6b83:b0:1db:d843:7246 with SMTP id p3-20020a1709026b8300b001dbd8437246mr916587plk.51.1708718994193;
        Fri, 23 Feb 2024 12:09:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbKbDqHLiVSd4eHF3zN80EMgTJ4Lq4RZ6tGQps+BcTSnU0enXX8zHs4xHYJ7/LlDy/aTWLjg==
X-Received: by 2002:a17:902:6b83:b0:1db:d843:7246 with SMTP id p3-20020a1709026b8300b001dbd8437246mr916570plk.51.1708718993800;
        Fri, 23 Feb 2024 12:09:53 -0800 (PST)
Received: from BPHKDV2-DT.corp.robot.car ([199.73.127.2])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902ed1100b001dba356b96esm12019730pld.306.2024.02.23.12.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 12:09:53 -0800 (PST)
From: Ram Subramanian <ram.subramanian@getcruise.com>
To: iwd@lists.linux.dev
Cc: Ram Subramanian <ram.subramanian@getcruise.com>
Subject: [PATCH v2 2/3] client: report channel if present in diag message
Date: Fri, 23 Feb 2024 12:09:08 -0800
Message-ID: <20240223200944.1343893-2-ram.subramanian@getcruise.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240223200944.1343893-1-ram.subramanian@getcruise.com>
References: <20240223200944.1343893-1-ram.subramanian@getcruise.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: 4HF3e-jzbAlHz1ggWzG5aZQsz0ntl_ZJ
X-Proofpoint-ORIG-GUID: 4HF3e-jzbAlHz1ggWzG5aZQsz0ntl_ZJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230149

---
 client/diagnostic.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/client/diagnostic.c b/client/diagnostic.c
index 6360b7e2..e1bd9784 100644
--- a/client/diagnostic.c
+++ b/client/diagnostic.c
@@ -93,6 +93,7 @@ static const struct diagnostic_dict_mapping diagnostic_mapping[] = {
 	{ "RxMCS", 'y' },
 	{ "TxMCS", 'y' },
 	{ "Frequency", 'u' },
+	{ "Channel", 'q' },
 	{ "Security", 's' },
 	{ NULL }
 };
@@ -109,6 +110,7 @@ void diagnostic_display(struct l_dbus_message_iter *dict,
 	while (l_dbus_message_iter_next_entry(dict, &key, &variant)) {
 		const char *s_value;
 		uint32_t u_value;
+		uint16_t q_value;
 		int16_t n_value;
 		uint8_t y_value;
 		int bytes;
@@ -145,6 +147,14 @@ void diagnostic_display(struct l_dbus_message_iter *dict,
 			bytes = sprintf(display_text, "%u", u_value);
 			break;
 
+		case 'q':
+			if (!l_dbus_message_iter_get_variant(&variant, "q",
+							&q_value))
+				goto parse_error;
+
+			bytes = sprintf(display_text, "%u", q_value);
+			break;
+
 		case 'n':
 			if (!l_dbus_message_iter_get_variant(&variant, "n",
 							&n_value))
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
