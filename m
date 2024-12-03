Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4B9370;
	Tue,  3 Dec 2024 00:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733184461; cv=none; b=avNHlFcWZMaNfeItJlQ/FLT+r042DiXNADmWYNGUJ3LnRKD9U6MWWr5ArA3rMgGhkJcPJzPqTzp94I5oMm23Ma9YAj2WvAsu7PZ8gcqh35CaZpYwDss6K8+EHbTKyiCzj+hFfTAzVDOluauBWm03dPXjEs+bgRb6B0RIrf7gws0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733184461; c=relaxed/simple;
	bh=03z7EK3gtGFoqwgI75tT1M93fK1d3arBjrEfiqXwjZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E8MRtZiNfW9jUPZgz3O9O1QciGaqNm+vMxA7K65b6gnmvMLYAYx4DUT9Setd3fPWE5NoZ61O5ZVQlRTAwZU5ADzdIjnz/p80Xts1VpeGCXCwUgKQTP1gFXmNY+8Jn8OOeDPGpo2zvXf9fL7682APZcJCBKI9CRB/tj7kKT4CfsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnvbI4tT; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnvbI4tT"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7f71f2b1370so3099228a12.1;
        Mon, 02 Dec 2024 16:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733184460; x=1733789260; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AQ/tTIL9PvObyfvrC6F0clZuidbknGd/JJ5j0jkVF5k=;
        b=cnvbI4tTQGUq604CLuNfHGnTSNEHY+7vdYn675fIXSZjV+Wa9uTQDVFgeTAZo8K7Ac
         UVxNppQ7csMSQZ0Jk6pMDuAeWnAEh2lcIIGPM8URdP2YYvoLpT1h7dK2tOlAJoFXIBnH
         xhb598vvxkogYSbpxb00ACAXuhiP93gZa1mTPCsbaNqFWqbwlwls5HP93B2u+XVsX9aB
         hAxZADEa2nGGhenfnAiPUNaCrWWtC2p13XBZ/487zX++atjL2Vj4pfHfD+hXstghm4kp
         MItJjIOiIkBFDF84KT0ZOemEgwGgxFxsA7V2DC2WLjtcea75TMJMFXaHTJBINJCdTMMJ
         Rbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733184460; x=1733789260;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AQ/tTIL9PvObyfvrC6F0clZuidbknGd/JJ5j0jkVF5k=;
        b=H/hVpX6rXwv5Ikeq9RlzCqgh8p3nz1W7ykmPijPqiF2dpQL2/eQwWnsKthFcKb4KD5
         zBAZ6G8RsXY3I4ZTGPCNI2e8fWV2NXju4I0DB6kInmEqR35kA9GLs8uoywvZ0uG85581
         xDCzgu6QkaNEYUyxZX3iBroHzWXmA2p+yDyntAS89M04eh3CDWE9E/nJgrZ3vTFjHqoz
         Sfo6PUIhYadCXwmShrT7UNE6zk5+TnCnVHQfXtY1WSdON1JucbPSbFJTTq7vS7eYz+eY
         JdCt0S/s6WBZlniIfTtcDfTHtektKix93RotEj6rIGdDlPZhykwjbobeoDWAJERm1m+X
         7yvw==
X-Forwarded-Encrypted: i=1; AJvYcCV10GrKPqELS7WV3M3x3CiVZPKPaIjkTllVgvaK+IuMmaUJQQqtsWwXe7AR8+WDnWoZKeHC@lists.linux.dev, AJvYcCWFfOs3rfKmHV198m1LHyesx/AMUdsfczZR+QxNzNaXdp0psNWTVhXW7bPfbmneFL/40EFpAX53@lists.linux.dev
X-Gm-Message-State: AOJu0YwKn9X+wIXQP0HpfWNN1ypVgecCX0TWSRWW3br60J7vAoBP3VCU
	XzcWecXJIeuQ1RBkdKCaFoRIgYNnCG/KN/3ZI4nwVbsyJ0rHAv3F1CqfVA==
X-Gm-Gg: ASbGncuF6a54YXJ7CPU/7G2eK6RIRKez+/ge5GCEbLSPDnUjv3F8CXNHCf/7wtKEvl8
	UtMDMKAzWMEZbfXuKTXRC/yGR50vasziX4BGbije/R8EGRqH301sTiS/zDf/4OFpkLTJzvTvCiL
	+qTGVRKX6u1aXcQcsaGw0yzLZMhH7NOCgyxFaaIVOm/188opS/JM5av9fVcdebVpv8aJtQ5JLUO
	IE75v4eomNEDdmvOHwQU2VIp6JZQOtwn4qboCOdr55m2H5kN1EyRg==
X-Google-Smtp-Source: AGHT+IFFdbHalG7soikG90vTc9U5Bw7pXSnAsii/cSvucm0FfTNW9tLsIM8ldnBcEeGS+nPo3x4/LQ==
X-Received: by 2002:a17:90b:3907:b0:2ee:c797:e27f with SMTP id 98e67ed59e1d1-2ef012770d3mr735968a91.36.1733184459561;
        Mon, 02 Dec 2024 16:07:39 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541849447sm9416425b3a.181.2024.12.02.16.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 16:07:39 -0800 (PST)
Message-ID: <974b30da-7a4d-41a5-8fd6-81aa70d12300@gmail.com>
Date: Mon, 2 Dec 2024 16:07:36 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Captive portal connection with connman
To: KeithG <ys3al35l@gmail.com>, connman@lists.linux.dev, iwd@lists.linux.dev
References: <CAG17S_PQBh2ONe8Jv91rosrKj-Lx99U-i11dh_dpQB6qspCypg@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAG17S_PQBh2ONe8Jv91rosrKj-Lx99U-i11dh_dpQB6qspCypg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Keith,

On 12/2/24 3:55 PM, KeithG wrote:
> I am trying to use connman to connect to a captive portal. I think I
> know the web page I need to navigate to to get the connection
> information set, but every time I try to connect via connmanctl, I
> get:
> connmanctl> services
>      GI-Guest             wifi_b827eb52ccd0_47492d4775657374_managed_none
> connmanctl> connect wifi_b827eb52ccd0_47492d4775657374_managed_none
> Error /net/connman/service/wifi_b827eb52ccd0_47492d4775657374_managed_none:
> Input/output error
> this is with this connman and iwd:
> connman-git/now 1.43.r2.g6bd97592-1 arm64 [installed,local]
> iwd-git/now 3.1.r0.gccd91fe5-1 arm64 [installed,local]
>
> Is this what is supposed to happen? I expected a connection then I
> would need to manually open a browser then go to the captive portal
> website...

Could you send the debug logs for IWD when trying to connect.

Thanks,

James

> Keith
>
