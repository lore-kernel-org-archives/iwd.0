Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C19616C85F
	for <iwd@lists.linux.dev>; Tue,  7 May 2024 16:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715098820; cv=none; b=Axq3NJ4NVkNV5lI5C57sWoF22/uR7Gb1yrtnEClR95oLr1zVYpDCOrZz5Qn/xV2Cw++pIdOCWj9PE9ir+8V3epnLlO2Sd85lYRCoZlMHVkKZDtQe7r15CcpuebTeIuqMpEmTFCrwcMucGB1GbW7jcUapiTsvZNGx1HpAnt2vIpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715098820; c=relaxed/simple;
	bh=/oVXVM1PxLkFvgryYdkwx4Mww36kO+8suQ5lMF7Aq7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FuYDc3ymBECZnWCJguzPW4Hn3bjCz/TH+xnV+Wqm1WErNx7PHPSpBgzmdkEJnDSOU65fMVr3/rkfOQrrb20ZJm1/j5v9Q2nybOkEVDrypyqby6Wr0XPlX7+AqjLKH2IzP8s4sADUKUlAuHVMnXfrFZlozYLqIShiw0LQv0dt6OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCcdp+h+; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCcdp+h+"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6f07115e6caso1030572a34.2
        for <iwd@lists.linux.dev>; Tue, 07 May 2024 09:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715098818; x=1715703618; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SU6CsGxIOacwdgk79IzHpxgpY2bSwG+vlpaYZmteQlg=;
        b=iCcdp+h+XbKHPs7lC50NUfC/S5gggCb00i/Y9q0BCpJ6K2EPQDZYBZOdG2vh5uKusI
         ztaT+oCsTH8rS4XL0+WBlUBBN9znr3xCnzAbR7U8tmTs50tghTVGONBj2Z/eHGve1sbW
         L60V19ij0fdyIMa4bIaiMBXdNuGqosjpunCEPE590ru+Shfv11cUygi+8kkyy3JeU9wc
         ox7F5LJP/s93D07wO3+XMxGT6/rpQ+VpN1MWqmjTSovJT23lD5UwCUdJsp3W0lzdbuTl
         EnV1sYSHKzNvr9shQgwWqp0L1suez/Yrw2hTXF4SFfrhR2a2f7JkOBbhYLigrzriSiup
         QnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715098818; x=1715703618;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SU6CsGxIOacwdgk79IzHpxgpY2bSwG+vlpaYZmteQlg=;
        b=P5PHQIpREhCsUfj8NUTXI51Zs3aOIZNgS1JvZjLoVUUU1Br+DMuuNBgjOfOENTCPpk
         xt9wTDG8/8JwKChHXrR8nFilybvsepur2f6eC3JwN60saQhrk/Z+0ILLRtxY1LEC/LSW
         a4otRRQbeI8QGr8rphr8kRNvsuuw/VYNGUDlNrH4Hgui5aD1Tz4dW6XTxOEXTQ5tu+5J
         PP1yna9NuA6aKMTar8PY543OBrX2cbncJEnS5g9VxyfX0NWW0eI8UB1cMEURh3CpRC7+
         y9Uxwy11ur5flizLqzCZhbPBb/pSsbtP0chykZMCpu/TG54R/2YqSlLF4iiulqhGU0jA
         B4rQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9tCmjmcxc6VP3plF3aDyG8ChfuJhlyFWx/Ta+rHq/UB1PGQqF5uTK89VagV1XLetno4Uka576ebukpg3SHnT3ob3C
X-Gm-Message-State: AOJu0YyodGuacCP6YQNiLjkuC8CHuHZj1y6jsvHsh7wyH4c4nRDXMCy3
	XHLdB0DmuuLPGmV4H38vc6jGtRzsmplxsmRhsswir27rR4V7Hebx+1llTA==
X-Google-Smtp-Source: AGHT+IEQbWO8PfZ4G1aeMgK8/BrR5NiRMPQnoQ/jZA6h6ZroE3UgheMSfxgzf9+gKTTEeaGvAACQiA==
X-Received: by 2002:a05:6870:72d0:b0:22e:e1e5:b8e with SMTP id 586e51a60fabf-240985a452emr61661fac.41.1715098818379;
        Tue, 07 May 2024 09:20:18 -0700 (PDT)
Received: from [192.168.1.20] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id hg13-20020a056870790d00b002396fd308basm2606638oab.35.2024.05.07.09.20.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 09:20:18 -0700 (PDT)
Message-ID: <be74ca08-0452-4cd0-9d03-b700667a9daf@gmail.com>
Date: Tue, 7 May 2024 11:20:16 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/18] handshake: add functions to save and set IGTK
To: John Brandt <brandtwjohn@gmail.com>, iwd@lists.linux.dev
References: <20240506003518.320176-1-brandtwjohn@gmail.com>
 <20240506003518.320176-16-brandtwjohn@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240506003518.320176-16-brandtwjohn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi John,

On 5/5/24 7:30 PM, John Brandt wrote:
> To add MFP support in the AP mode, add utility functions to save the
> IGTK and to add the IGTK to handshake messages.
> ---
>   src/handshake.c | 34 ++++++++++++++++++++++++++++++++++
>   src/handshake.h |  8 ++++++++
>   2 files changed, 42 insertions(+)
> 

Applied, thanks.

Regards,
-Denis

