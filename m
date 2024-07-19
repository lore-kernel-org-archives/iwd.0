Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EE9146A85
	for <iwd@lists.linux.dev>; Fri, 19 Jul 2024 21:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721422806; cv=none; b=k4LtPEArouxvV3qyTklcZcSMUfAHCAR3UIsJvdf3SPKrLl5wH9n2waq5uJj9daF4WECw8chL4yae/e74yrBagMfXQluN+OG2yVSn5qUVERr1m4dQ2P1Wm3p0z5tjNn1kHaACK/tpRvbwvqX5z4RUPjdSFiP8cw/OqNFRHfj7SzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721422806; c=relaxed/simple;
	bh=PEImxl5wXUhehcTaUZMAAlNAZ0wfU/ehtPW97PXTRrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BkV8wL+DCy8aJOsTEbcU3q6y35cFvJj7St5PeqyHPIHGWQp/iS+nq/R7nd1IOI+NS2UyLK3FqfRq0zdTjTczZOgZBvqF9eWTwqP1B/CIUJMi5mZgUgI/oy4Ug/MWEVEEK4fTHbPcpNcIiIyEUB7Vpv4u5hnoFzqkl6dr1KcpICM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6jYz53m; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6jYz53m"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3d92df7e83cso1238170b6e.0
        for <iwd@lists.linux.dev>; Fri, 19 Jul 2024 14:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721422804; x=1722027604; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tQkpzjyRI0o3UY/5DLBQbRojX+ion1sNE31+EIHRXQU=;
        b=H6jYz53mJMMSdSvvIokCT8LaMkoF8PSNQLktw+1AvFTdHMmWmTZdzKELW9H04upiWA
         Lz19pcSDxWQetIS6PB6iYWw0ZYU+etqYYmNFvLuzcLp6twFNXWJ+zrZfw8IfFz8QAxPK
         Bm+sdnq7gAMBG+xdw60mFeV2TA+XVOhM8iNdnbFVZeuiDWD74R5ciFdMuNgBtUvkoafT
         tk1ZvWnfvH7vy+0XgNN0oDx8pkmusuZdv6jS+C0wvBC4V9lyNJxKcRbf2/78EGneorJa
         MWtJ9KHIqkej/2jwCg8jC2oJc9kDgHTeFRAeL7ni6QD1iO3y0uDfdiLZd3qMGMwMjZOi
         I7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721422804; x=1722027604;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tQkpzjyRI0o3UY/5DLBQbRojX+ion1sNE31+EIHRXQU=;
        b=XIPsDiCrhsfjHefLy3523A9Jlb+EeMZ6tli5p3SCmuLiisF+hJQVDbQ0jEVmTivO00
         R+YIhGJAmXsg65MHCA9UpMCjQsRvlAfcc+Hd1RZl6yZ9BVu0YbL5mKbOJqhDLdN5Ihy2
         ksur/s24YlD+sDUESsxutYHP3rScmvJsM3Lhko1Lr65RwfsdqsMHoNlkvViGsXumhtwA
         FbFBBCjNAq+P6J91ECmdkVCrWDd2CexcCKy0FNeFhHXBIaVIah1xaBwahZS/oOkAnMWD
         p7cC/XB4BX7jrsua7HxNqiCZx2PocQ9alnXrZN0UzPWlsMUgeW/W22SwfEAlOpx4+7ge
         MKDA==
X-Forwarded-Encrypted: i=1; AJvYcCUnLDDwm9zlvd+Ctb8H1Qhkg1tAS4RW7RRs39H5/WcGC1901DCdG4iELqpok3bgW0PN15W4V+KIw8ilACHAcwMuiKz+
X-Gm-Message-State: AOJu0YzlvC/bHpE+bQZmkKQuikI105EtgHs4PBqAKgH4zCVhgqtyrbBS
	ftsSFbjS2XSTdjwJKEExB+FYvpsKpsUX7qwfgyjdTEip5tdG0ijZmHG8FA==
X-Google-Smtp-Source: AGHT+IFOSo2/eqWxaq/AICu3UMAfICtrxoz+eACSN1JcYqh6TfjGIoFsSw2kFSoKXIDW3sHMz5oWdw==
X-Received: by 2002:a05:6808:1407:b0:3d9:dabc:7b7d with SMTP id 5614622812f47-3dae64fdb11mr395845b6e.15.1721422803866;
        Fri, 19 Jul 2024 14:00:03 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3dae0969c8fsm428626b6e.12.2024.07.19.14.00.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 14:00:03 -0700 (PDT)
Message-ID: <8a021f22-346a-43c1-9b2a-49bcdc1deed5@gmail.com>
Date: Fri, 19 Jul 2024 16:00:02 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dpp: relax requirement on IWD being in a disconnected
 state
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240719181926.3888420-1-prestwoj@gmail.com>
 <abdda292-7c90-4705-9c81-9e11ffaedd10@gmail.com>
 <74956b29-14c9-47ae-ac7e-4294f52d2147@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <74956b29-14c9-47ae-ac7e-4294f52d2147@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

>>
>> Have you looked into how WSC does this?
> I hadn't, but looks like it waits for a disconnected state before starting? We 
> could do this too in DPP I guess. Just check if station is in any pending 
> connecting states (connecting/connecting_auto), set a flag, and start DPP when 
> station signals its disconnected.

My view on this is that the user has explicitly indicated that they want to 
connect to a new network, so any ongoing autoconnect in station should be canceled.

Also, I think it would be good to be consistent between DPP and WSC.  In the end 
they implement the same use case.  Whatever we do for one should be the same for 
the other.

Regards,
-Denis
