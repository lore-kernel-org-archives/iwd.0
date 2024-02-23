Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1DF1448F9
	for <iwd@lists.linux.dev>; Fri, 23 Feb 2024 20:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708718999; cv=none; b=WQcM9Eb6jsZzl3n9vckJim7QVhroOKIVaEq10l5UdlpydP9367FQ30HNFShh+j0UXXCA/ANElDu0J141e5nPLya66gfxKwaXl4CNS1eX9mwyzduvtQIv1Wxld68e8wSUl87h0YAE+eLtFG6SJrEFfcDJ7T0XrCauIYYeVD7x2Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708718999; c=relaxed/simple;
	bh=woeo2RuIrzLBVm+zYXAqHl+FAzjCe9pL+3QNrvncyWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MT7m0Ki46TMY2nTZA9hd84A4aveOTyFH+H9rU4Pb+KwaGDVBgq5aiOVmEwI72f8e0pkvuGvClXh9qI1CYag43XuH3TUbZ2NPtaFNaUeDiOjSQhsF7t42UywZEu/hbnaiImrw9a/TtLsO443QOhAOQFHi8JS05K2fdsCNDPvBlbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=OhjkAXF1; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=eNFuA0qO; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="OhjkAXF1";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="eNFuA0qO"
Received: from pps.filterd (m0286617.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NChQlv031335
	for <iwd@lists.linux.dev>; Fri, 23 Feb 2024 12:09:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=banAqEH4AumsXhxjQiBCzD
	2dMU26eauaRZHnld+5CPk=; b=OhjkAXF1V5pNk5QN5LchVbojcI6Kk6MxjXXONN
	omrm3Yvui37gEdG+1tBmZ38QZP+p8DBKvSvVZVqcarsZzOEDXQSSBYGjZq6G3vs+
	sefyTpQWor8KBCahSwRvm+L+F1ny295S0/wqYB8tFXze9gmL/7O/vJXwTkI8u9sE
	FyvN7AFqMAKXastjQogIy/7Qm5Bn9SLUgTvq6eXTgwUfCASdZhPiJ8lYb17soM/5
	6sw13vTT9mNf/N2ZjV/F6r185Zu8IT8djefeunMW432yA7NJO4Nv5xEYmWEcaTUI
	r40jvAlzWSwH2SeWKZzFJWT2ysE71ZLxXxX8M42GhBk0MiAw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wd564bcff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iwd@lists.linux.dev>; Fri, 23 Feb 2024 12:09:56 -0800 (PST)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6e4c6240704so442784b3a.0
        for <iwd@lists.linux.dev>; Fri, 23 Feb 2024 12:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1708718995; x=1709323795; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=banAqEH4AumsXhxjQiBCzD2dMU26eauaRZHnld+5CPk=;
        b=eNFuA0qOqT+AhxK4kd8W/f7gxKsE7wN8V83nFzKmJQXZblHuCVqONHZlYTwNhuzYhT
         3V1M61mB1jfMf2KDyhXY1vLFnaq8GZ/0qF9WVcDXB2xAXjwT8gzetfqqXa2d1nUXzgZN
         KN0fjT1L34Mj3dYHH9/A9ievKOvcULmIiK0W2rE+g0B/3LCvjZWGQTY7/HtAKpvoxNp0
         E4gVtpQGcrpo0YR2uRtYAPZE9qqJcdb6pyUJZq0mdZUDGhI/8KDEsJCWoQ/HVcKnhop4
         h+OsR5kAylVjN84fZcyGVsa3rEaaBG3kt5/CbmHeA2msMj9m91/sTuSxyD+6Kx/6ZqXm
         du3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708718996; x=1709323796;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=banAqEH4AumsXhxjQiBCzD2dMU26eauaRZHnld+5CPk=;
        b=sPKgevIQ1Vm91QQ6S7ocUPcFMJqnHT75xnGgG8H8YgPM+ziS7Z9PGqUlQ8Ah9c3KTc
         XG3rtAyOK4CP/rPtMLCqNOuH09KEaUDrA3moixsKgbcLtB+wGOwErzL8b7D4pQWTNodb
         QUoMz2OGDRmrSjzOUMw/neWAgdQQC7thHElL25FehKEFk6ETpojgP5qmlYsdX7EBCKsX
         Kn5vZzLyyaY21S1nBgpEuuXzaNcTZ0SHKyVG8Z6LtCoBNxI0nq7VzHWxzyRvZWuBpx1K
         XxKR+yGoFs+v8PM3zTJQlAMLa5yoCxAR0Zh+cZZAJDEt0XFFbNr0USP6eUs+aoAvLdg/
         14ag==
X-Gm-Message-State: AOJu0YziIR9PD+irJOL9Z1lAPMKnETB+V02JVrxB87d+9I+duRY4usS0
	jnhFHONdIAtH750r+WoXqyfVDCvqRTmblONajAFF3eSR0XI6yzflN/9uJpBe5aKI4sQxprXuX8U
	zvo0hCfV/14VtEOg5Tk5ilm7UxeM97Jqe1DnFKAkkx3dHTi96pxIXlIOtXVUI4PXl65TsZnqmb9
	89pFG05rCmGpoxAlNAPuUNxuayPz5S9HuFT13k2wtkRsGt7Ig=
X-Received: by 2002:a17:902:d3c6:b0:1dc:1e4f:9b3f with SMTP id w6-20020a170902d3c600b001dc1e4f9b3fmr923981plb.24.1708718995779;
        Fri, 23 Feb 2024 12:09:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEf/mTINhysvuFcH8RdC7q8LqAD2U/YZ39NcAttEx4ahqQ+FfllCW3r93t0+lmQwWgzaQINVA==
X-Received: by 2002:a17:902:d3c6:b0:1dc:1e4f:9b3f with SMTP id w6-20020a170902d3c600b001dc1e4f9b3fmr923954plb.24.1708718995347;
        Fri, 23 Feb 2024 12:09:55 -0800 (PST)
Received: from BPHKDV2-DT.corp.robot.car ([199.73.127.2])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902ed1100b001dba356b96esm12019730pld.306.2024.02.23.12.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 12:09:55 -0800 (PST)
From: Ram Subramanian <ram.subramanian@getcruise.com>
To: iwd@lists.linux.dev
Cc: Ram Subramanian <ram.subramanian@getcruise.com>
Subject: [PATCH v2 3/3] doc: document channel field in station diagnostics
Date: Fri, 23 Feb 2024 12:09:09 -0800
Message-ID: <20240223200944.1343893-3-ram.subramanian@getcruise.com>
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
X-Proofpoint-GUID: jZDhCcYmCOcB2IRKMslIVYIJhrmm2UmK
X-Proofpoint-ORIG-GUID: jZDhCcYmCOcB2IRKMslIVYIJhrmm2UmK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230148

---
 doc/station-diagnostic-api.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/station-diagnostic-api.txt b/doc/station-diagnostic-api.txt
index f6e099b5..77651366 100644
--- a/doc/station-diagnostic-api.txt
+++ b/doc/station-diagnostic-api.txt
@@ -23,6 +23,8 @@ Methods		dict GetDiagnostics()
 
 			Frequency - Frequency of currently connected BSS.
 
+			Channel - The WLAN channel number of currently connected BSS.
+
 			Security - The chosen security for the connection.
 
 			RSSI [optional] - The RSSI of the currently connected BSS.
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
