Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBC3280CF8
	for <iwd@lists.linux.dev>; Wed, 23 Apr 2025 14:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419929; cv=none; b=RcSgPeHZ7i+wO0rcdutWcLYJz6G7l892xMSDqTqkY1BA6x8fax0Ff4EQFYyJfvH9h0nd4yzUpuJfFvuKFcRu/SbEieJr55xdmUrgV+QAVtUCRUJRzkeSYf6snxSjcLLFRDybcqfiKJYNzvkDrwqjlU3rbVvg4/uP55E7XGZkgDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419929; c=relaxed/simple;
	bh=dT7ne3K4PDKhXtB/3PtscbN4lf4Dj+U0W7c782lJkSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TNWsqnl+8Ut0OGMoAH261qi7ZPmoeYpp7B2m5CZOx7a5Gkkl1akL3HfM/uH9AeoSCgL4UnU8Kbt8jmSaBjdpVwK4uGa36fupmOb447qJDq7Opdu0GvWqhc5o1Fdmlybjj6rsjxyHHDYoa+5Mqry7gOE0NH52P06wYBG6PfpsOFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0eUg/V9; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0eUg/V9"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3feaedb4085so3587946b6e.0
        for <iwd@lists.linux.dev>; Wed, 23 Apr 2025 07:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745419927; x=1746024727; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mbDzyaM8cGclY8RsLwfu7Mqsh4nICci7jUmI6/d+1eg=;
        b=d0eUg/V9XDPh8/L6d+nRAKYdyRCkKlvr91H6CP0PpCI1xGTAnTV0Po13QFrqyJuq3o
         NPWk8xItb1TaSzUa7N6pk9VTKe+JIvPGUosQcGjaGKmRR06dsvWHYYrcXTQVlZiVCQOL
         4lnwg6jueEMfusLT1RFMjU2MUXDmiQsq8XEcnp8HiDghNlSLeRye5Yc7otbRqrVgZDK3
         ymPNC6zK39DlebZ+ugWJZLKzp6JoTd1mye5n5fXY3eTgUAEtbQh3LsB6HDItodMGnrN/
         TZuMM0jH/cC6T0hd6dYk+UIX4w8+KRDhPy6GKlAZtMOexuDvqwMoKHHpftYOQch3nMHS
         Jfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745419927; x=1746024727;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mbDzyaM8cGclY8RsLwfu7Mqsh4nICci7jUmI6/d+1eg=;
        b=dFChOujLNbJ+dFnlPtUYnv/qiGLhbpDqnhBjmF1/lHxfsVzpZcMqNshjHp5Nw/5DPm
         8VUw/a+tc3loCs3qqbT+tLSpLATLa+4s7FrzU9Sc0WghTEhgZ/AJNLBJSEvTRGt0DPE5
         6+JwS434pY9K+Ctp4jKTKyH7USyaV2bDO/C057CwFkZ5Ak0hwVTGMhtgcViR1kaWPn6t
         Tn25oZPTfDi6YX4+eiQoaf+XKp1Yx5Oq4gh9J2e1Gbz1I99P3n4mW/1hj1LL4meRFYEx
         1r8+W8KonW/BbnYJQkBckfVedzi6NoMIg+TA4cZvJLXm1KbdXyRQJPXqGX0p6Wjk+8ak
         B+Ig==
X-Forwarded-Encrypted: i=1; AJvYcCW+9p75tHiIj23d6RJfQ45oM0Wg9XxYExFlX4XzNd8fE6U2zfVR76cPSEP4q9B9XzYEcpg=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2mI0/V7J8rXTuMqdpt5vidsQCG0QXt3E3b13uMFcsn/wr7p2d
	y8A8ui5O39hwy6zRq7+W+nce/xyH0mWHpSduuTo9b/NQE1ddjXMnytLo7Q==
X-Gm-Gg: ASbGncuWpgs08LUBxeGYp80x1iqDC1IMlW8r+KfXcqIJDUMEIJXeBx5mfGLRsDehO1B
	Uex30QcBvoakXSamiuu7EP1+6mvWUgOcsSUZV831Czmy54kigSGZO4TlFoAmoc8qkjYYWZywH+9
	TBLoVIxDiPesx9T2f+fD5o8XKO3xefwfV1mwPlfBYJ1yEygbeWJj+4Hq2BB6BVPOQSZIeBSL0Np
	RWL50bjuI550BbMNBR2WDcyVx1sWNp1lG5Vk8h5G2h1Zo87Wve5ZkRLCts0axfbRFevmpV7H49r
	78AvzuFY7Tii0NiJMIVph1pHy4fJ1uXDvcMLCIcoc22UCJQrDMbx3+DJf3TgXI+8T8Bx9MwGjfk
	v37be+w==
X-Google-Smtp-Source: AGHT+IEqRUUsReXc+Q/YUsx1VZ3r70s9Vt70mBNyfSoRjt8YowMs+1ndP8a+7RBazaS8AgUMo9H1Hw==
X-Received: by 2002:a05:6808:3319:b0:401:e949:6381 with SMTP id 5614622812f47-401e9496605mr411709b6e.19.1745419927564;
        Wed, 23 Apr 2025 07:52:07 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-605ff6aa38fsm2591872eaf.36.2025.04.23.07.52.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 07:52:07 -0700 (PDT)
Message-ID: <dfd01b68-2955-4fff-9f71-2e130e745c16@gmail.com>
Date: Wed, 23 Apr 2025 09:52:06 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] station: update SignalStrength/Frequency for BSS
 interface
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20250423135458.11337-1-prestwoj@gmail.com>
 <20250423135458.11337-2-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250423135458.11337-2-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 4/23/25 8:54 AM, James Prestwood wrote:
> When the BSS's signal or frequency changes, update those properties
> ---
>   src/station.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/src/station.c b/src/station.c
> index 14c93671..85ed2898 100644
> --- a/src/station.c
> +++ b/src/station.c
> @@ -545,10 +545,21 @@ static bool station_register_bss(struct network *network, struct scan_bss *bss)
>   	 * scan_bss pointer, as this one will be freed soon.
>   	 */
>   	old = l_dbus_object_get_data(dbus_get_bus(), path, IWD_BSS_INTERFACE);
> -	if (old)
> -		return l_dbus_object_set_data(dbus_get_bus(), path,
> +	if (old) {
> +		l_dbus_object_set_data(dbus_get_bus(), path,
>   						IWD_BSS_INTERFACE, bss);
>   
> +		if (old->signal_strength != bss->signal_strength)
> +			l_dbus_property_changed(dbus_get_bus(), path,
> +					IWD_BSS_INTERFACE, "SignalStrength");
> +
> +		if (old->frequency != bss->frequency)
> +			l_dbus_property_changed(dbus_get_bus(), path,
> +					IWD_BSS_INTERFACE, "Frequency");
> +
> +		return true;

nit: This return probably deserves its own commit + Fixes tag.

> +	}
> +
>   	if (!l_dbus_object_add_interface(dbus_get_bus(), path,
>   						IWD_BSS_INTERFACE, bss))
>   		return false;

Regards,
-Denis
