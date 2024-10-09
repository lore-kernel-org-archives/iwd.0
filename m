Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448A47E765
	for <iwd@lists.linux.dev>; Wed,  9 Oct 2024 16:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728493093; cv=none; b=ZbgCz10+csJ2NtoowXR9/lrsobwFrT5s6geCpEEFfhYWTZ70gGfxgEbsBNRgAJZcObW9UqYDBSzGTi8EG1s5NLUBoZ3OPmacqulbE4NQjye/bstROxIdCXOQfBLpT9BRAmQLvRyn1BzLZS4bzvtAkzwEJGqkhfMA0pfvv7aH1HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728493093; c=relaxed/simple;
	bh=BRsaOpk8duTGiHgANNtWVdmAygBnTVYogFHuRANSioE=;
	h=From:To:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=fh5g2/ZaNgsl5xf5VPwZKLAjxojBEi9B+8UhgEu+84oFuuSkaXJznX6Q32Tf+yCWIM3+MRSsAp1pO6U4hmytnXYXyPPche+beaM4mU3Pd+J0UkqkW6lTM0sU10UrzkSD5V67/nh4VzEOpVrDAvkrWOYTKZqLaVmCGXoukn169RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FJ50jLO/; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FJ50jLO/"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4311420b675so5833315e9.2
        for <iwd@lists.linux.dev>; Wed, 09 Oct 2024 09:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728493090; x=1729097890; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aDOsgozvAG/6WuwPqf4QLirogzGKi0vhBtaITaSY1bs=;
        b=FJ50jLO/Waxoj34qJRaVH9zaW88fIxvkcFF/E9q88Ln04Nbfas8OEkYzh5o/gTZXmV
         ouneDaa+acaZjGMm5a095ruRzPcNQWTk1zW50jAieXLC7JM3EOq/IG7A2dW1D5G0aoaT
         K33jtsFFRAn7puMNG/0pNSvKgfmR0n1XKNqbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728493090; x=1729097890;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aDOsgozvAG/6WuwPqf4QLirogzGKi0vhBtaITaSY1bs=;
        b=m3SOD3Xo3vPjo62VN5uJHsXchrPYc6oI0f/Xcp1silhQEUNaQNxb+xfQSzQ6hrndQ0
         PQcNgm86wvUaBG1++ua1x6ksy03OCN1viWIz66705+2E7HmrdsMvpmMDq4Dwxo2yDctK
         QeBk1eEAsc00y63bqjecpTReslv7ERrnj4TtzNhVCe8kk4qHeI/6I7Zrf+uweYEZYaJ4
         jaODBOsLX2n7YO7QDBJNV6AnYpS3ASxfQ/xng8UGFCm7Fru8QBHZqc4HeQCV5Nov3O+k
         GlYSnz+DXsz4c6XHi20im+f7KiPBhO3ViqS/95eYShjCmhj3WjoUsYU3a3AVdGH4EO2v
         c6fQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKjZJmKJvyWYogkTCAdP3gnjk1sQ92gtTsoZLVxbKMTwlwINGwsEJvszhUc8rFYw2hvz0=@lists.linux.dev
X-Gm-Message-State: AOJu0YwdRJRHRsUQUf97A51CFVBSMyk6hltrTgBxT4rxAhtloBqH74nw
	dLiaWSS1dDqefhlZoaQpf7drJMvZrbfsBZrbDlGIM0ygBTRIj97sHlVhz9Hckg==
X-Google-Smtp-Source: AGHT+IFahIU1Zj5tJNczbWzsY8qIl/NA/7oOMSy8vlCmezH5E8vc9PVRVMAaBkw1TreLfgi+cBdvMg==
X-Received: by 2002:a05:600c:1f0d:b0:42c:e0da:f15c with SMTP id 5b1f17b1804b1-430ccf511eemr24191825e9.20.1728493090426;
        Wed, 09 Oct 2024 09:58:10 -0700 (PDT)
Received: from [10.229.43.125] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d59b2ddcsm25766835e9.38.2024.10.09.09.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 09:58:10 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Denis Kenzior <denkenz@gmail.com>, Martin Petzold <martin.petzold@tavla.de>, <iwd@lists.linux.dev>
Date: Wed, 09 Oct 2024 18:58:10 +0200
Message-ID: <192723774d0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <d91f33df-e9d7-430a-b1ca-13cd1dee973a@gmail.com>
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
 <d91f33df-e9d7-430a-b1ca-13cd1dee973a@gmail.com>
User-Agent: AquaMail/1.53.0 (build: 105300523)
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On October 9, 2024 6:07:16 PM Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Martin,
>
> On 10/9/24 4:43 AM, Martin Petzold wrote:
>> Hi
>>
>> PROBLEM

[...]

>> IWD to 1.27. The situation became a lot more stable...until we tested roaming
>> setups. It seems that for IWD 1.27 and maybe also later roaming is completely
>> broken (at least for brcmfmac). It does not connect (No suitable BSSes 
>> found) or
>
> 'brcmfmac' -> Full MAC.  Full MAC implies that all roaming is handled by the
> firmware and iwd is not (or hardly?) involved in roaming with such setups.

There is a module parameter to disable roaming support in firmware, but it 
is enabled by default.

Regards,
Arend


