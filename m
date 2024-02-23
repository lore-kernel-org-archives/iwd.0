Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E295D490
	for <iwd@lists.linux.dev>; Fri, 23 Feb 2024 20:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708719131; cv=none; b=ChNyUzRIXoOXOgmByeyf9LJTxWlOnCBoq9TnaY6U/lI8EK1Jj2EF22PXGtps43O3hRPFkh7qI0VPwx9ly4zh4fo5j/XR3cSNv9woAszEEMw1eunZTRl8QT/GfTxsYH1H9g6FoNvYRm7EbZB69fKrdpbk3FYsXtbdovTm43/duIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708719131; c=relaxed/simple;
	bh=nhfwtWcUASf8dycM4Vp32IphI5ypGbitLtp1iddH2CI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sHQIRgEA/vEb7uUacdL43BuwRFuW8lsyJ1TWRSKQvSrMOQy5enB3zOWT3FoSJ7lQAFwtm7F9wqG2sjaI9PfnmNEX8wU71n5NZU1TSH4ue6UifzTdOjKutCsl76vPzdf2w1USXqoXch7QurGzweaI7RIDoxsGJHUX6pqTiGt3g70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=g4Idiv5x; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=hVh66vmP; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="g4Idiv5x";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="hVh66vmP"
Received: from pps.filterd (m0286620.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NDRSLH024359
	for <iwd@lists.linux.dev>; Fri, 23 Feb 2024 12:12:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=mime-version:references:in-reply-to:from:date:message-id
	:subject:to:cc:content-type:content-transfer-encoding; s=
	ppemail; bh=nhfwtWcUASf8dycM4Vp32IphI5ypGbitLtp1iddH2CI=; b=g4Id
	iv5x3kW7Vv5cqujLMhQb3nEIORp64Z7PFxcn3x+lzixli2bnppi+b4td2mNwnv78
	+LE6vRYU9jQH1mZgbWVaX52radDX9KHYUy45ZSC4lwAiIrpGrgFCtXSd1A9VYnIS
	QxYpSWhI3lcsDGx0cOsXcM0q6tFc4q3Dggt1o/7I3nauADFx2Mk46CPo8HXpqJlB
	tyLOglbx2ByR8uIjfaGYGJ/KHM+vkNczT2x61s9qC5ThBrSPqfI4r7UKDqA/CjQH
	U2qabAclgQb/Rm2lN4ZgUl9vFUkFNea8phJeZqKsBBRJYGca6trIsyZG6JcoeE17
	Sy8urGWvIlo/T0dMPw==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3weeq28xnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iwd@lists.linux.dev>; Fri, 23 Feb 2024 12:12:08 -0800 (PST)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5a03e749ecfso1374712eaf.0
        for <iwd@lists.linux.dev>; Fri, 23 Feb 2024 12:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1708719127; x=1709323927; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhfwtWcUASf8dycM4Vp32IphI5ypGbitLtp1iddH2CI=;
        b=hVh66vmPjrsr60wCqnb7TabbHv6ArrGLoU0QPi3KsivVdDzOP49xUGIhi5jT5gyk8X
         jfTMmf02Z49w1SnHuEXDHs/Mk6PzoCggqIcnpobHSWAKrTyDdDpx3n5JZlYsJa/du25h
         ELcqeXmgbGEadU48t4RuZwNbu/0kHEI9eOvEo/5fwKjZfn4Rr8wGxZA3RJTR2ugcb3uF
         8L4FRI3O0x3vhenrLbWudKSCwSr+0t/5cBY9fACo5bZJnU7GGrykEBSRql5IjgY04Y0D
         gWYuGhpzHd/PNiMMTQUFWlaspe50Q+8wOk2cXIw8f+xT5MdXRuSxw4DZCiz6ifV21/bw
         YKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708719127; x=1709323927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhfwtWcUASf8dycM4Vp32IphI5ypGbitLtp1iddH2CI=;
        b=eipmKmf3hDwx1mN1EXrzk6tHaxKmGGiRBX3strd5Km82jlkur1K11S5zFMJJYLiIYt
         lBBSAGyJOOthlyQE7Lit0GbGa8ng1oH7/dB/APZwhtKHbO1zisjjueGcHvQ58ygv6l1L
         8JYf/tXoQX8Xkz47l60VpNL/oZLjEJ0Im6pOCoi4dsRmOWDAX2UqA/hYOkqJEzTzJJRU
         T5eyYdvH0z4TMeKp22ot+PE+Cp8xxGRHvKfGbUv8lFTMkGfPsHdoZ0A5i7qCtWt5jNKj
         w1rxfEI0D0MWGN8Qxr1qaKLsYpM9wK9rzXl7dYBo5POuyIiYmiGbm8UR/LkShasc6L6k
         2aAg==
X-Gm-Message-State: AOJu0Yy+Tgv6Q7LDfGQyyWmhmlNg3Sen42iB1kxvVtboz95cotaL8y26
	leAMVvA4yzwhjbEmYOFoEnZppU4grnoikdQaPWhimWMSXuQ+YC2n1UX1bGcoN0t9Plf52HmMjCv
	/IRgnx5R+MAEk3LqmGwJFrzdMNuEYhtvSqE5EgYvEIzC1IJMjSZzQqfWxgyn8PzT+8UnfunQ1Kz
	zjbjBdYxKMJM1zL/efIKmrTWWYF2Uic3yA
X-Received: by 2002:a4a:620f:0:b0:5a0:3e01:ab58 with SMTP id x15-20020a4a620f000000b005a03e01ab58mr1062237ooc.8.1708719127593;
        Fri, 23 Feb 2024 12:12:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUfroLf1ymc6TePFcYaYEHX0pby83fn4ETaFucCuDa0PEcNHiq7jqjS6RBEGGhH5tU+nPx5X57wHjRgG9PMrk=
X-Received: by 2002:a4a:620f:0:b0:5a0:3e01:ab58 with SMTP id
 x15-20020a4a620f000000b005a03e01ab58mr1062223ooc.8.1708719127370; Fri, 23 Feb
 2024 12:12:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240221214624.601337-1-ram.subramanian@getcruise.com> <6736199F-95A0-4C40-87D9-889D3E49E948@holtmann.org>
In-Reply-To: <6736199F-95A0-4C40-87D9-889D3E49E948@holtmann.org>
From: Ram Subramanian <ram.subramanian@getcruise.com>
Date: Fri, 23 Feb 2024 12:11:56 -0800
Message-ID: <CAJCcR_v6WPp-+AvQU7X00gFNuSO5N1EVuX8=sOW2MO6FU3pLbw@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH 1/3] station: add channel number to diagnostics message
To: Marcel Holtmann <marcel@holtmann.org>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: Pyi7-jwg-uYQeY4hab2u0U7wDMzwALPG
X-Proofpoint-GUID: Pyi7-jwg-uYQeY4hab2u0U7wDMzwALPG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 priorityscore=1501 adultscore=0 mlxlogscore=996
 lowpriorityscore=0 phishscore=0 spamscore=0 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402230149

Good point, Marcel! I've submitted v2 with the uint16_t change.

And thank you for the review James!

Best,
Ram

--=20


*Confidentiality=C2=A0Note:*=C2=A0We care about protecting our proprietary=
=20
information,=C2=A0confidential=C2=A0material, and trade secrets.=C2=A0This =
message may=20
contain some or all of those things. Cruise will suffer material harm if=20
anyone other than the intended recipient disseminates or takes any action=
=20
based on this message. If you have received this message (including any=20
attachments) in error, please delete it immediately and notify the sender=
=20
promptly.
