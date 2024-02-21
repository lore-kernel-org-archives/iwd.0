Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BB9126F2A
	for <iwd@lists.linux.dev>; Wed, 21 Feb 2024 21:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708551994; cv=none; b=tzLKgC8fXApxuCrxe5cz2Br71IeaW4rI54ILz+eU7j2f41ysWhsTekP1S6KxwIDkeLY2QRh45f2O58KqyXvvjXkaFCgobNS3mqcHrAbAhxfvivLP0ZB4cSdEw9lIovM2VYUlk3wRl0NITwvObrEaYMaRx9aqlRgFV6SEkTpTTg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708551994; c=relaxed/simple;
	bh=2WIGSMYE+KbX4Rdj4sOAcDFZnDKqEWBwbL4HaQ/SzGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qmbpr76LvY7WS5pTyXFwjDu+0uITEZmJelkn3GhmBo4B6G+xNszt4ymJTlnYZkSpQ2V4+rcDEoMrWnJJ0yTFrpQ4YdKkCLhyWpgdbl1KJJjUxO7UywNl4hm9o2tQhfgExXNUpTTQdb6lxWiBaxSFzFSOecDs+/uO9h3F2kvR8RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=UBgJhTCZ; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=Fmf7xhMn; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="UBgJhTCZ";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="Fmf7xhMn"
Received: from pps.filterd (m0286615.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LFjR2T025470
	for <iwd@lists.linux.dev>; Wed, 21 Feb 2024 13:46:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=XH4lKmMscX39gUw63Smrqw
	1MqeVktXrxfGzGRcmylLA=; b=UBgJhTCZrWcsSch0MDnIWEn7l2fCVJ+j0JHLSp
	a6fCS3r6dipFjfhWbkFS2cgU2rM0r1aQ6xhFSc/YtPyOhjG5ipP7Mbw2U6zoBOY3
	3M6EvNigZrrKT3UmbPJKB3ltvNkQf80I3qF0hc/PXEmHiQkygn0Z9MQFOZ10RRq1
	wVmCdbs0mUEhG+y3jDT/d/a9VcmGRlAiAXij467xLDlwLYUJzH1lNhZuYXeCi4Nr
	+tRDYE1we5Yn5SYR+9jc8cUs/fu7eHvHvBFgrEy8HgXdi2cVoOvlzC6NcLiyrXWg
	DsadlbTTpRAsPGJtAaCzeXiS6/g3q+Bj6wF0SbPhYRaF7uDg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wd563s1g6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iwd@lists.linux.dev>; Wed, 21 Feb 2024 13:46:32 -0800 (PST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1dc30890157so12142615ad.0
        for <iwd@lists.linux.dev>; Wed, 21 Feb 2024 13:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1708551991; x=1709156791; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XH4lKmMscX39gUw63Smrqw1MqeVktXrxfGzGRcmylLA=;
        b=Fmf7xhMnwfBrbzTUijhY5iY0xkf8dUXTgljpweLwfSI6LezoGNQHtcdYyz4jJAbtgo
         bWLl3Nc12+0ReN5wMUSUwVcoXqrUKquY74xK0Rz0Q1nzwpT2s1SBwYEHjtKd/AvgrLn5
         uIxV5auOqBXh/v061LWV5tcX1Wt7GK/RW/ASeEemRygg5NCL+Sn02Szsi62NVuKXM9C2
         SWQKr9MKDa6uCQHIiDsHJeCzZ+5cNUlR/jvCdssg0AeXm8pGp2f4R9tHmDZeLESq4ckO
         S/MgVxNyqe/1HbBSq7Tkm0pgcsKeeHzfL1wS1igzd2E1UvmOVVzGPQyabsp4wiNN/zp2
         bSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708551991; x=1709156791;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XH4lKmMscX39gUw63Smrqw1MqeVktXrxfGzGRcmylLA=;
        b=RQUhL+m60YasnShNL70y9DLwm6sO2LJxB+lKzkGgLRjDWugzsl67ZCGf5y0jZ5J/ZZ
         +F+ZyItjH1HLs7W9lSq2F5+vAeBbrwyIRTO1jWuuzEEFDBAb4/I/a4GKqQOy4QVGJnRB
         gtJbmRCwmtiUPfN4SzyjfqUbm1sFNfThLiPIrQ+aL1aFi6Dmmtf/XV5mUhsu2ckWslKA
         FE47o7rlq9DBPpgm10LpU3YgTyBY4d1h4xvVTjsm41i0d3kJbCCJXmG9W85cE+8pDIK9
         CQ5c5EcOf1pItbrFio6QpiYs+JMOOL4QKa91CHxiY0tRhB7iKzs5dH0Vx9MNWYPwyRlB
         nXOQ==
X-Gm-Message-State: AOJu0YylmVYteKp9YVAqD/gjWFgfp9lfc2l24AxLECFJ3IH1yKevp/P8
	pi89+NVVN6g1NvwBa7PWaKsXUgIs8CF6VpO982tyZk5dYND6Z0E13k+TNgC+mgOCkcRtihMEDkE
	y0Ce1AKbv2dU1iSrTZy7QGaJh0SgqVBQru3PSzdN/C8GAiZy/lft6ECQoKQBD4K0PBDNSudesS7
	FBhcMFZ/Npg2mw3jwynqagN8XjxhcF6ZUryfwXymZHipeSlBU=
X-Received: by 2002:a17:902:ce83:b0:1dc:1539:6cf4 with SMTP id f3-20020a170902ce8300b001dc15396cf4mr7164496plg.48.1708551991381;
        Wed, 21 Feb 2024 13:46:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmXW+nsewsrBh3DbOSsVxtRhbCKeOKI5zPR2Qy7pULd/apivMdeiRKtNWIBatM4V82rkjObg==
X-Received: by 2002:a17:902:ce83:b0:1dc:1539:6cf4 with SMTP id f3-20020a170902ce8300b001dc15396cf4mr7164477plg.48.1708551990958;
        Wed, 21 Feb 2024 13:46:30 -0800 (PST)
Received: from BPHKDV2-DT.corp.robot.car ([199.73.127.2])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902b78200b001d7137acad9sm8541955pls.57.2024.02.21.13.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 13:46:30 -0800 (PST)
From: Ram Subramanian <ram.subramanian@getcruise.com>
To: iwd@lists.linux.dev
Cc: Ram Subramanian <ram.subramanian@getcruise.com>
Subject: [PATCH 2/3] client: report channel if present in diag message
Date: Wed, 21 Feb 2024 13:46:23 -0800
Message-ID: <20240221214624.601337-2-ram.subramanian@getcruise.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221214624.601337-1-ram.subramanian@getcruise.com>
References: <20240221214624.601337-1-ram.subramanian@getcruise.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: USPo814iDBMMRRcps2_GeYlW8h5lKdZ5
X-Proofpoint-ORIG-GUID: USPo814iDBMMRRcps2_GeYlW8h5lKdZ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_09,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1011 suspectscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210169

---
 client/diagnostic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/diagnostic.c b/client/diagnostic.c
index 6360b7e2..e4050201 100644
--- a/client/diagnostic.c
+++ b/client/diagnostic.c
@@ -93,6 +93,7 @@ static const struct diagnostic_dict_mapping diagnostic_mapping[] = {
 	{ "RxMCS", 'y' },
 	{ "TxMCS", 'y' },
 	{ "Frequency", 'u' },
+	{ "Channel", 'y' },
 	{ "Security", 's' },
 	{ NULL }
 };
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
