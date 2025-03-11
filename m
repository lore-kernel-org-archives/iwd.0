Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5A0156F3C
	for <iwd@lists.linux.dev>; Tue, 11 Mar 2025 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741718392; cv=none; b=O+NEzI3tPIuy4P3alzcJhu8NwUfsaNcmU4SdhMSNjeoXkNODCt1M72Xpd5M+iES1sFUrHTTEkL6zHs1jPSipnyTv9bSzGZrUa1gyf3bH3ZFdnZCOJsJdB4YVWrHvANN/C3jkhACYyc9Di+Oww9Gfjg3I6xvr3c8/hI0VT6Ho0fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741718392; c=relaxed/simple;
	bh=npZ/02t+oXkfATYtKpl4tsa3mibQWlT9O5Mr63qyES4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z5Ic0MYrzujBdbrf9l96ymtGDZDUqateqeUkTCPE9Q7GPTpO4c27BXhUK+LqAGJ6xqpEhtUjtUr7uZhSUjNV7h8S45+e8r48Ig6Gj/rBnfGZxwXLBS2SIx9Z/H7mqdnZ32uEF/ypbvS7zgF4Kd325GdtgL5Nif+Yoiyy4/Bgtj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kr7mRgGT; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kr7mRgGT"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2b2b6019a74so3247953fac.0
        for <iwd@lists.linux.dev>; Tue, 11 Mar 2025 11:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741718390; x=1742323190; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6IDI1Oxp/A78HIJTlGnbdyn/Geenm8psdo3EZq+Us/0=;
        b=kr7mRgGTAvxaWcz+1fCtKlmUVnOO3Dh3KyrHNoqZnGhVjL1cOs7jXsQHvOijIYjt6i
         vBi/Wl64kGVLI25zABKrYUPTgUI47EC93UUAMr4tIkkbHEAIUC+FxZgk3sBrrnPYesTH
         SbvTh/biLkKuarj/GuMXr4/jsJUgV5eEFda2qj0Bx6Xzbe5ucg+ZzxA0u2hwXmwlSO9+
         nh8XridNTAHFWO1hxMHvXw7GJ87z1E5vIbJtSM34nzH0Zv4Lt8B3V2i1vpYIFVWRMKBq
         /6ikpNRRNwOO2GiX0jFF095HlnrYbsg4GASbCguem+wOauD7gzH8v32G6DVWA2wIDM9r
         LKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741718390; x=1742323190;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6IDI1Oxp/A78HIJTlGnbdyn/Geenm8psdo3EZq+Us/0=;
        b=qMNy1PNSvyUPu9HXSraexJfMtOtIgLc3qSFd963r2AFtPsZzTpFjXs2HiK6+Wz6NkG
         oKVg2Dz9zPZDwXUQ4kLldFh3UfIoGQjbo7yOE5nGaHBMhTmINga8FTy3sjq8K3xbRQGc
         tHpbqi6MnnVlD14U+KxSXXF+RYPkwJj5gKigm4t5mGDDby1kofef9SiLlBiWElTpZ6cB
         yDlnl04PaNPiM+4toOrYZ321aQ5D182JYl77zFjvDigE7qPcHlJyNMIXc9NiBEchjKHi
         KSl5th3oJE0IqsYtbb3OUFknfjz8Q5U/dBUD1Ww1lyevi5A3EFJ+pdRptSebmujul6EP
         oZ/A==
X-Forwarded-Encrypted: i=1; AJvYcCUIOO7ZV2pLQxr8xRvV9DckFOs2UB20SCWaop+9Xc5IWrw6WSdi1p/Zq3lx4+78iDzqGqQ=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+tKJPROVYXpJRXEuhsJWqGoDiWPpeTz0TlDVvQq4hnYKyZb3S
	ECd9S9bv/P8nnO19hfKaUmZfJblOzoApOcVGbnQHyv3gcwXEOkT2gYPwlA==
X-Gm-Gg: ASbGncvmAv1gfnpsBQwdLpnns7vCmRxGfuv3iy0vlv1DlCCSW+MuTshtJzuXwv9vhWe
	2VqRI6xq4yth9nLr/uNjTClzPJHeRPYbvEvp0mAUBZqR00At/cTNUxGy5u5MyBy8HPi/qW4v5d0
	nmZO36ia2D0gwyyVsMlIM9PJFXBHxznzSpGAWhkmq/rVAfs7hBfNycWOTLogtCKJpjJes1u2tzF
	eWGDa1KeDilswVTNxFBuF85nD0FV+tKzEytws9TYshFqy4xMGLtQFHLT43siS6LEksERDpFjxLe
	pgBF/92ndBJBCyMRFTHXdj2lGALYXdHfleCanqu1lgjcyLqak8dakKCVAJDyOP20E6FyKp4a1jP
	MK+1tgWNYCQ==
X-Google-Smtp-Source: AGHT+IEoleSCUICoZmzI3ULDYKyPXqUMt2C5OSAH2aDOJ0rxVS62dxNkWCK9+TVSp9mOIT9kiVkQzQ==
X-Received: by 2002:a05:6870:c141:b0:2c2:5b16:1f0 with SMTP id 586e51a60fabf-2c260f8555bmr9079178fac.3.1741718389931;
        Tue, 11 Mar 2025 11:39:49 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2c2488b19ebsm2703203fac.12.2025.03.11.11.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 11:39:49 -0700 (PDT)
Message-ID: <e0790aa0-6a05-4786-9a29-94be749c30f7@gmail.com>
Date: Tue, 11 Mar 2025 13:39:47 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wiphy: non-LAA mac randomization
To: rushiimachine@proton.me, iwd@lists.linux.dev
References: <20250310225418.198643-4-rushiimachine@proton.me>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250310225418.198643-4-rushiimachine@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

On 3/10/25 5:55 PM, rushiimachine@proton.me wrote:
> From: rushiiMachine <rushiimachine@proton.me>
> 

I need a real name / author information in order to accept patches.

> Add a secondary option to `AddressRandomizationRange` to not set the
> locally-administered bit of `full` randomized MAC addresses. This
> allows randomizing MAC addresses to not appear as Locally
> Administered Addresses (LAA). Currently, there is no way to avoid
> having this bit set other than setting `AddressRandomizationRange`
> to `nic`, which undesirably copies the entire OUI and only randomizes
> the last 3 octets.
> ---
>   src/iwd.config.rst |  8 ++++++--
>   src/wiphy.c        | 17 +++++++++++++----
>   2 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/src/iwd.config.rst b/src/iwd.config.rst
> index 895a1012..55b95db9 100644
> --- a/src/iwd.config.rst
> +++ b/src/iwd.config.rst
> @@ -107,7 +107,7 @@ The group ``[General]`` contains general settings.
>          the permanent address.
>   
>      * - AddressRandomizationRange
> -     - Values: **full**, nic
> +     - Values: **full**, full-uaa, nic

What does uaa mean here? user-administered-address?

>   
>          One can control which part of the address is randomized using this
>          setting.
> @@ -119,7 +119,11 @@ The group ``[General]`` contains general settings.
>   
>          When using ``AddressRandomizationRange`` set to ``full``, all 6 octets
>          of the address are randomized.  The locally-administered bit will be
> -       set.
> +       set, and multicast bit will be cleared.
> +
> +       When using ``AddressRandomizationRange`` set to ``full-uaa``, all 6
> +       octets of the address are randomized. The locally-administered and
> +       multicast bits will be cleared.
>   
>      * - RoamThreshold
>        - Value: rssi dBm value, from -100 to 1, default: **-70**
> diff --git a/src/wiphy.c b/src/wiphy.c
> index fb544fe6..ccdc7645 100644
> --- a/src/wiphy.c
> +++ b/src/wiphy.c
> @@ -64,6 +64,7 @@ static struct l_hwdb *hwdb;
>   static char **whitelist_filter;
>   static char **blacklist_filter;
>   static int mac_randomize_bytes = 6;
> +static bool mac_set_laa = true;
>   static char regdom_country[2];
>   static uint32_t work_ids;
>   static unsigned int wiphy_dump_id;
> @@ -778,8 +779,11 @@ static void wiphy_address_constrain(struct wiphy *wiphy, uint8_t addr[static 6])
>   {
>   	switch (mac_randomize_bytes) {
>   	case 6:
> -		/* Set the locally administered bit */
> -		addr[0] |= 0x2;
> +		/* Set or clear the locally administered bit */
> +		if (mac_set_laa)
> +			addr[0] |= 0x2;
> +		else
> +			addr[0] &= 0xfd;

Nit: Prefer L_BIT_SET / L_BIT_CLEAR

>   
>   		/* Reset multicast bit */
>   		addr[0] &= 0xfe;
> @@ -2854,9 +2858,13 @@ static int wiphy_init(void)
>   	if (s) {
>   		if (!strcmp(s, "nic"))
>   			mac_randomize_bytes = 3;
> -		else if (!strcmp(s, "full"))
> +		else if (!strcmp(s, "full")) {
>   			mac_randomize_bytes = 6;
> -		else
> +			mac_set_laa = true;
> +		} else if (!strcmp(s, "full-uaa")) {
> +			mac_randomize_bytes = 6;
> +			mac_set_laa = false;
> +		} else
>   			l_warn("Invalid [General].AddressRandomizationRange"
>   				" value: %s", s);
>   	}
> @@ -2884,6 +2892,7 @@ static void wiphy_exit(void)
>   	l_genl_family_free(nl80211);
>   	nl80211 = NULL;
>   	mac_randomize_bytes = 6;
> +	mac_set_laa = true;
>   
>   	l_dbus_unregister_interface(dbus_get_bus(), IWD_WIPHY_INTERFACE);
>   

Looks good otherwise.

Regards,
-Denis
