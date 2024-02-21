Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B06127B57
	for <iwd@lists.linux.dev>; Wed, 21 Feb 2024 21:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708551997; cv=none; b=o7xRHDmCnNBzySV3oebF8sl7H8P6l06MjRqLx/+k+TjV2qcZ+2niDj1vRjawH996lOZ+zMAahIhrk6XO0zQ+xeuDlRYmvXHWFzFQJIS4l+R59lnpGb8fWlGjw+/7q5gV/vqPBHsHY8OCiw9NmsWFzD0hbAjkbW0J0TBhTbCguoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708551997; c=relaxed/simple;
	bh=woeo2RuIrzLBVm+zYXAqHl+FAzjCe9pL+3QNrvncyWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B31GgrxP0PZcc30UWxIBCzLOD/rxWEmiQAHKKw+ajVB1xqulKD1/kr9VDKZXhc2FcNmDHnzURtJhmattXT+7rV/zm0jLkFGD+GLJdOdq51DaMfJW9rUxNsUJI9KYwNwMYfbiBwY1/XILXb9qQBQzIV9N7Z//Go2CULIh4dPvIY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=QURvZlUZ; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=IcpxlP3q; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="QURvZlUZ";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="IcpxlP3q"
Received: from pps.filterd (m0286619.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LEtsQD007673
	for <iwd@lists.linux.dev>; Wed, 21 Feb 2024 13:46:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=banAqEH4AumsXhxjQiBCzD
	2dMU26eauaRZHnld+5CPk=; b=QURvZlUZDpo2HhLbHQQhw6bujD+FKyHYLVbEIR
	DM4faKy27kZ8vs1ReWf9t2I9eL2xuO7ZD/6l72tAwm6uLSuBCPYa+rZ2qyBZb4py
	yFRgXMIxsRulvhHccfVaHLOyrH9InSQhuAPIZspzGbLkXJkVuJUs67Qp55c8sx1z
	/wXC9XFmd36svhKzCAhvxBC7RvObIogBhvrQbjFdatLs5blGYaP7CaNuouXXjx1R
	KEBei8ZGr6ipqbmhmKnw6xhdmN9B4WCZu8EhTAGYw/u6R4T9SJHn5yTc4emqfnD6
	6TEg+E+Yk84FkyaLLaoiSf/72n7rnt8JuhI2rB8yC6+2VHkg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wd563s1jj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iwd@lists.linux.dev>; Wed, 21 Feb 2024 13:46:34 -0800 (PST)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5d396a57ea5so5295927a12.2
        for <iwd@lists.linux.dev>; Wed, 21 Feb 2024 13:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1708551993; x=1709156793; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=banAqEH4AumsXhxjQiBCzD2dMU26eauaRZHnld+5CPk=;
        b=IcpxlP3qnRyr+LOVRyErKr/cI5FUmhNYXpLoczzjcNOU0yPVFyx9dOlSeP0+5hvM0x
         caPtIN158EyPTk6C9VB1nkFPhw/BLjcehhIBh7ZGruLJDWTRsxYL7Cx4KCNr3WwpMDw2
         W6VG840+DzwdpCYUOIWk/kUybXIbH9wsmfQLpldpfxvkpfUmPDE4vGao8D3f5sYNpwSV
         mi4+YD+LU6LkPYx09ZczI7kVVIOyU7zG4/YljR4waNqTLOlnn9q/4rI+1acg+ebUB1IY
         C9ILZSSQeh+zR81ShU9UgSEsZ4h3IZQglTMZTYHcWPPRAHJ5NQNNAO6onpZLB7zs3uD5
         DatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708551993; x=1709156793;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=banAqEH4AumsXhxjQiBCzD2dMU26eauaRZHnld+5CPk=;
        b=aPlqCr2ZP4ALbfLa5xGXgQg2mzGZbvSugBWq3Dz7QrGMxrByPDHTM1Qxfp45P3UPyO
         xuheVHnC7Tw3ELP9tj7M+pioN1RDP2utHl3XSuY/FRk5chI8IGUX05o66pZGyqN83Mmn
         z79Aib2cyfFg15sqL8FJ+dMV8+8k3ZQCXsShG58X7nIvoAAFm6NsWI+Ear2dKyk/DREB
         oqjbaE6U7uEq0Yu5f19xLSUWXDk8cAJ/Nd1+Z4IREkR0qrlFMtIXwwLV7nqgn21c23gv
         9noYvIDHJ121K+K2dCq2lXQUezEOoO3kFHIxjtG4uO5GAJ1NO0RX+WoaQxU1kBehSdd6
         q7ww==
X-Gm-Message-State: AOJu0Yzmy+SwHUpDUXTkaqwVAreo8cQ2N0tdUn2Y4NxjPLF80htiIglg
	EqpRCrb9RTKhyRC5pRBBhqZGcwHnOlF9MnCHudJExbPnFEcYU6tCxrg6Q80gG17KjoxzpvvcTNg
	yNm40oCU0dfHWhwGnI8czoVH4dJIebCo4hib+DPokrvRDopogq19kW0BDzYUmwjw8gbUcJjN4gl
	NdNCEJXzKCXXHO55EqmaTupmDhpvtgSYgui8lpV42BMKKy7Tk=
X-Received: by 2002:a17:902:c944:b0:1db:cf64:732a with SMTP id i4-20020a170902c94400b001dbcf64732amr14849558pla.62.1708551993085;
        Wed, 21 Feb 2024 13:46:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHks4wlb+miedOGLebaJ8r83t3sOB++Q5nFoGcKfM8QYNdhQWWb/2+IMKtioo0fQwnAQXvJDA==
X-Received: by 2002:a17:902:c944:b0:1db:cf64:732a with SMTP id i4-20020a170902c94400b001dbcf64732amr14849537pla.62.1708551992673;
        Wed, 21 Feb 2024 13:46:32 -0800 (PST)
Received: from BPHKDV2-DT.corp.robot.car ([199.73.127.2])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902b78200b001d7137acad9sm8541955pls.57.2024.02.21.13.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 13:46:32 -0800 (PST)
From: Ram Subramanian <ram.subramanian@getcruise.com>
To: iwd@lists.linux.dev
Cc: Ram Subramanian <ram.subramanian@getcruise.com>
Subject: [PATCH 3/3] doc: document channel field in station diagnostics
Date: Wed, 21 Feb 2024 13:46:24 -0800
Message-ID: <20240221214624.601337-3-ram.subramanian@getcruise.com>
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
X-Proofpoint-ORIG-GUID: w7xBT_L-OukB5CsNh1sZE6MPF_--n6FX
X-Proofpoint-GUID: w7xBT_L-OukB5CsNh1sZE6MPF_--n6FX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_09,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402210170

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
