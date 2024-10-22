Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CF613AD26
	for <iwd@lists.linux.dev>; Tue, 22 Oct 2024 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729622861; cv=none; b=sRIabbZWNzHHvTqnOy4u7AV+9Yh0b4qsHpJ23wriRUI1IjfInYWdvcUPk2H0FgGwe/R4P/DCfjHK3AR2diyBTjccUZ0dvcuouwmRbwvt3cq0voDCJytFzVv7iVclxmShE61u7aVd6PfXQTnaXadViBiDroz2IkPMD66mfLFt608=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729622861; c=relaxed/simple;
	bh=NRURVwFtfUqNtMVp6+c7lAwyt2sqm1i0vCTCiH8tq/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=srTG/7z1XMDZryIT+PpMrmpTXr4IcWhazegrb3GbUq1z7qv3RKWw8QvDk4Q6iqmq0jaDAzM8sb60dlf1pZniyma+rDUfGEwAYj4IL10+rWtxSONe9NHDCZzhjCvqhCbHrtl3nV1nhmLz1x+mrzLS2/iGnntv0Y7wr8qnqIL4kLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZacfUcf4; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZacfUcf4"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e28fea0f5b8so5674930276.1
        for <iwd@lists.linux.dev>; Tue, 22 Oct 2024 11:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729622859; x=1730227659; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V9f+KKvEaUqnTtuZVrPMYKIx/h1wiuVLqKD4D07OjzE=;
        b=ZacfUcf4HF/T8X80S84MmmQgg8oRP02V+VbFPeqitiDijm+Sx6mTSfP0u9UwgmxUZ0
         OkF85wl456jCWbKgk00h9sYZM9XPkqujKXR4Fi26ymBsK218yKOrdz1P09nYgVwd56qE
         i4mKhe6RYuydHNXbLz0rgxsS+hwQmFAz5rQjjD2GncMzJVRFTXhvN154lDSs5XoaEsM/
         eqFyJFSs/ahjcMNOdToHPKu2pvK9SQVBJvAO8rZyxm47OcmwXxZWY74hidqbd/opU6h5
         lFR4Tls+qXDPsacNHfCH8Ec0j02NibnGsrlAbD6xly2BKVPY18dPXMzslBNO7KI16c0M
         /JfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729622859; x=1730227659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9f+KKvEaUqnTtuZVrPMYKIx/h1wiuVLqKD4D07OjzE=;
        b=KiB1SSNRWqKuwqAqCJ9iY6d8e9KnycmwVIpzWYkITWDowA4CS+Qx00xG9zbz75e5As
         XBZmN3+hIcu4z0CT4nH5o2y3dB2UTvysOM/lKveknmuCfMKRDqePTOjUcP5dXX1y4ItL
         WEgITPQ6AG7FeNz4OzHVBHQXgAq5JEa1uRUlYhslD8WF9JJnXOPKvDD5n2BhSopsXkGA
         Z+Mpitu7slZqjlj7C81nHNVXQhX00SJbntHFUOjPdxB9Kldnp1molhdFIFn9sRUQSv1+
         VqUt/yCGWJ5rNWGE5FSH8jiODc6WHU9Bsl0K5mAYsR1JuLl6T+Wzcwyk6qnTjUckMIqn
         IZGQ==
X-Gm-Message-State: AOJu0YyIZw7jYLBdF5Vbq03ZKewnq5HJqNWTkl2e8GgDW073z+XDGzbU
	1CHKz7V+2ldmKi4PjyuM9ffFkkiLvtiej4+QUIVGqzmUJ+yqEFD9
X-Google-Smtp-Source: AGHT+IHLO2ngZUq/3nwW9TV3URjFAcyJPctmf7NfSOvSXRtrR0liNCadYbMzphc2Yj76HBmioFGfCg==
X-Received: by 2002:a05:6902:260a:b0:e29:5540:7f85 with SMTP id 3f1490d57ef6-e2bb11e55b0mr13801056276.1.1729622858675;
        Tue, 22 Oct 2024 11:47:38 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3d69453sm32062771cf.77.2024.10.22.11.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 11:47:38 -0700 (PDT)
Message-ID: <68a6c65a-0c53-4679-aa93-8cd9eb66228d@gmail.com>
Date: Tue, 22 Oct 2024 11:47:35 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: Denis Kenzior <denkenz@gmail.com>,
 Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: iwd@lists.linux.dev, KeithG <ys3al35l@gmail.com>,
 Martin Petzold <martin.petzold@tavla.de>
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
 <5efc11fc-9c21-44a0-b282-5d41bfb96a8c@gmail.com>
 <f496ad63-e2a6-46cb-b7d6-1a084523c7d9@broadcom.com>
 <1761198e-9f41-4e5a-b2b9-a1652732346d@gmail.com>
 <6898cd84-c7b9-4fa0-aeb5-c7a90d81b58b@tavla.de>
 <b0afc4f1-6496-48a4-a11c-789ee08368e4@tavla.de>
 <5a128900-432f-439e-9008-3b303ee72eb1@gmail.com>
 <2dacc589-9927-40f7-85ed-5f6b2afbbd41@tavla.de>
 <192af85f1e0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <2ab8601e-1601-4d4f-b58d-e9f23877650f@gmail.com>
 <192b00cf460.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <54a62c50-5c9b-47c6-b8ab-f7369381fdf9@gmail.com>
 <c57706f6-2d5c-4e73-bc42-e2b7e4239a78@broadcom.com>
 <CAG17S_Nq1BjYSzSrqMne-6-sO3HK84XEbPf72oh-GM87kd2uJg@mail.gmail.com>
 <2236075a-8239-4f1a-b878-adfd281f3dbb@tavla.de>
 <f1f2b4cc-367b-43df-a637-b380d979e11d@gmail.com>
 <6170a2a5-dc7d-4182-8b83-1b43b93c4f46@tavla.de>
 <06e10782-0c31-4cdd-bd2b-31d1daec03d5@gmail.com>
 <b3b58b08-da06-4485-a980-edcc42d2453c@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <b3b58b08-da06-4485-a980-edcc42d2453c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Denis,

On 10/22/24 11:44 AM, Denis Kenzior wrote:
> Hi James, Arend,
>
>> errors out as its unsupported. I don't believe there is any way for 
>> IWD to check if OWE is supported by the driver, and we just assume it 
>> is (Arend, maybe you know of a way to check this?). It appears that 
>> what you need is a new IWD option 
>
> Indeed, there's no explicit way of checking supported AKMs.  The 
> NL80211 API isn't much help either:
>
> /**
>  * DOC: OWE DH IE handling offload
>  *
>  * By setting @NL80211_EXT_FEATURE_OWE_OFFLOAD flag, drivers can indicate
>  * kernel/application space to avoid DH IE handling. When this flag is
>  * advertised, the driver/device will take care of DH IE inclusion and
>  * processing of peer DH IE to generate PMK.
>  */
>
> Perhaps for FullMAC, iwd should start checking for 
> EXT_FEATURE_OWE_OFFLOAD presence, and if not present, do not use OWE.  
> Too bad no upstream driver actually sets this bit. Unless... maybe OWE 
> works with other FullMAC devices and we'd break things for those...?  
> Kernel folks really need to chime in here.
For an explicit option what about the transition disable stuff? I know 
you set those options based on AP capabilities IIRC, but could we allow 
a profile to set those manually? It appears that is checked for in 
network_can_connect_bss() but I need to refresh myself on how that all 
works.
>
> Regards,
> -Denis
