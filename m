Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BC0227E99
	for <iwd@lists.linux.dev>; Wed, 26 Feb 2025 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571739; cv=none; b=WKqzGUnZ9rlYpezfMiyZZC2CN8YYhFQBnnycN0SziBHOa9K2BxC1a2BrNG0uvAQ5NsnaDr3mZQSZq6s9b46A92KqOfGmsRUP4hTZxdyBaYXoQ3EmqHxvqM0zVeBBKP0/qMIX1OaxxfVgSJ/9gHxPl78lp01QWqubRR3s/nJ+3rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571739; c=relaxed/simple;
	bh=3iu/gUaoPIOpOw4rZdhvZ55z0ll0qf8Tg9Ypkw8Z3gI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fw7li//Pnj85rbmPUjDG50SaUN7WXSp6AukqLSyz5LxsfFH1H0NYjJDjfCerzaR9ao710987LuBhLg1bwve7y3IliJjCzVYZ5ev4O3mHcSxSlbP6cPBT2MvyujlF8rFQRsl+FBk7xq/Ai5B0FEFFKAJCprlRnjmmVseNVZtlid0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8ucpfN/; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8ucpfN/"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22104c4de96so115861245ad.3
        for <iwd@lists.linux.dev>; Wed, 26 Feb 2025 04:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740571738; x=1741176538; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3iu/gUaoPIOpOw4rZdhvZ55z0ll0qf8Tg9Ypkw8Z3gI=;
        b=Q8ucpfN/xFwMUC8/lD0oHsCP04fRBHjPlZ0XJhmzGMEQhybugkGVIPVa69Ybl3N8dd
         mR7VkBzxiWBgeRbQ1Eh5ViYlSJbOf7w40BalawvoHyoN14miu7rdEUnrKrswOriEjGh/
         M/pGyLK+nxfW7A+mJgofQ/t+WIyW1Hp4+II1jUDFk3dHr3itkLAY9Mfg6pbRb81u5to+
         FgeA43mCyvUb0Wjs5WrMvAqYHGqA9Q24G1/j/Zakvmq1J8+G2JoFV7JvRIUvD9CplF6Q
         WVof0zPA+VAoFkDUwdZgcVpt27e2AZZV6+QEq0FxsqucewDsuvEuQkiuBzjSx7qArSSU
         uUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740571738; x=1741176538;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3iu/gUaoPIOpOw4rZdhvZ55z0ll0qf8Tg9Ypkw8Z3gI=;
        b=WiKrGNB5h424X/LvNo+X3nrCAX581CJos2AqCPFkeCkXuQeh/YRvupkSYnIEv3S41x
         CGp0v/TH+8741ZHdmfzxNl6PxFL2q/0HW+2Twism589V3Ahc0tsxbRo1pm383/j+YAMU
         hNFZDgxdOG81aTLWenaJfpACUkgSlLpl7JVSmZDRv2Z8NNK8/PcMSaAb6P95gzS7c0yH
         4nGB3qSed5DOBg2nA3t+jiMg1UL308SOpAiYP/ZCUlXEM9Z7w98lLFwI6LC1FqNEhVq6
         ZzO+Gx0y67svGV3ZvG4yAzoN0h9trzjcuJzHeQnBg4hNT84MPi4KdsvT/F0Yzmtmm6ip
         Zkxg==
X-Forwarded-Encrypted: i=1; AJvYcCWG/jDMSdnDhPnPNQMWHQ30Y5zdUjgrgNrxDrDPPC0eI7f7aq1R8Yf91tsH/G2iOERQOzs=@lists.linux.dev
X-Gm-Message-State: AOJu0YybS3cX1v3IjHtKaLifhMRPbOK8zOs5FVZqW9qKmeSchNrDzg97
	e9DtpZD/PnrBVxvzQBVTLYtavHWDZDvBmYtlJwO19YEEKI312tAp
X-Gm-Gg: ASbGncsM0EBfDuIR/Ri5RddYmOpEPV86yVTiDh+MM7ejSpgtoKwlw7WuKIZc0se598a
	8NjBMa8LBVzsZWntTeVKEKkQceNPU12ZM7OTwzrw9j8f44gbUyt7/+GyVVDPBIgRHyfePboOali
	iNx77DjCcQZ8VFTRBtfqyGWrzLKqnddkMDsOWAihVPlKPcv7r8HSIeJKhuSub0L4RI5bwfhACg0
	WqIeCdyiTaXPaQyIXrO2hlJI7IFYb5T1TLVNQWoi28Cz1XDOuyFlbteBlu46rwY6njth0FBH9tx
	JavJRQRWuGg9VY0lj1EbhSnlzlWPKA==
X-Google-Smtp-Source: AGHT+IGiWInUE9fhoWo+O2DlIgdxdnTTBntYYEjdMwLcTpt6RBhEbTEA+8UiG7LcCngNl5aN90k85g==
X-Received: by 2002:a17:902:ce07:b0:223:28a8:6118 with SMTP id d9443c01a7336-22328a8668dmr33073075ad.31.1740571737775;
        Wed, 26 Feb 2025 04:08:57 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a092f1dsm30208795ad.114.2025.02.26.04.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 04:08:57 -0800 (PST)
Message-ID: <adedcace-ed93-4fff-9927-e58383489abe@gmail.com>
Date: Wed, 26 Feb 2025 04:08:54 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: EAP-TLS support in AP mode
To: =?UTF-8?Q?Frederik_Br=C3=A6ndstrup?= <frederikbraendstrup@gmail.com>,
 iwd@lists.linux.dev
References: <CADs2FCEpXNpdrVOjiRN6i5WG8=HayYRqQ5P-L36dj=zLyYh3ZA@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CADs2FCEpXNpdrVOjiRN6i5WG8=HayYRqQ5P-L36dj=zLyYh3ZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Frederik,

On 2/26/25 3:49 AM, Frederik Brændstrup wrote:
> Hello
>
> I'm working on a project and would like to know if there's any
> existing, or planned, support for EAP-TLS in iwd. I haven't been able
> to find any info in the wiki regarding this, as the only page I've
> found is https://archive.kernel.org/oldwiki/iwd.wiki.kernel.org/ap_mode.html
> which only mentions basic WPAPSK
At the moment no, AP mode in IWD is PSK only.
> Best regards
> Frede B.
>
