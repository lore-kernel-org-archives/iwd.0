Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F348842049
	for <iwd@lists.linux.dev>; Wed, 29 Jan 2025 14:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738160249; cv=none; b=e/xVyys5u7DwzHDRUcRwprlIT/c26vFM5Pdf+cwKykr59Z01/cotUxWZ6Ug5rGY91sZoV1/kuGnOnkkbb2k1QydeEkdGqMsqtA07iBIVwpGJxCh03LAcPPsIrqVFTrGJwRhAZ76/PApBXDnf9dQJZrOusIDHMHWobCZdDfK3m0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738160249; c=relaxed/simple;
	bh=0UaUaLkk6MAQN6VdDxRDmOIXXja+HAerz4nQA783FIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vDCVK7tQO0NUzx3nqpgEgFV66+0NxgFqSiYy1EbP/lwJ8ceL78nC8Z6Nviurezg1U4zYWJKYiLXr8Q1LygNJutD+kfj6KIo7N1zu+b6gnSgygmhX81nisoAz1zz8pVxy533LxrCjyVbopk0tvWOcz807Vk7inUBysbiSs966Dfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJFRuPu6; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJFRuPu6"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-218c8aca5f1so8926905ad.0
        for <iwd@lists.linux.dev>; Wed, 29 Jan 2025 06:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738160247; x=1738765047; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3i9SvNqwrL2HLtgZe9bm+ZNM5T893REv5QJqThdijCI=;
        b=hJFRuPu61SR1iKtot1Ialb3V/TYOvQMPl4VkK9vqFPxiK1ytUECFL03aS8wBjMKSDP
         o6TVsehQhIL/MpHoOlBI7c0/lOuL9fwPhmHGIrVVeRxRsjsggKbjezK7u/XTJQpuTuly
         aLThhx/f27FCQaxqtCTzMWCMWWWXaAEAwKnwXxGbTAtb2MnVT1pP/sMRAJNgdoxqjtvP
         c16AQwHLSc1jvya6Wpe8/a7NE4tTkvzdakvAydgjXTYxsNHOFXRxWHCEZPEgAxCeHvjk
         ObFNG3uJIHrlbcGSJuGKA3U5myiSElsJ2SaQ5MuyRR0mEDvmJUfF8qKLQNRNdC9NRWOs
         FJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738160247; x=1738765047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3i9SvNqwrL2HLtgZe9bm+ZNM5T893REv5QJqThdijCI=;
        b=X35kA/gdJy50H5EaQ02Y6xtYAhr2QpxGbkrmO1fPgUS9QsiUEz2ZoFI09Tc4/cyElt
         JWkwqFPtZjxJBIV3/lYA1CLGrKUKs0maU5pxEhj/G831eCFF9Kl/RMHwtMYihcVTJ0op
         QaxrZDglui726Xj2VhnutXML3RH8knN7zJOdY2FH4h58SCykrgd/kOqce6AAyshETjJW
         E7z9vSVSBjkW2tiS+SVmmqxLjp8/RO8W0PAaMY2+aO5nUqGcVpCk3Sr9Bah5me8QD/XK
         VN0oG9k2NlQi5SsyRb2WT+GAz8pWH0VLSujoKmkL89fZdUarzH4GQe67cKrdETlgz2mz
         xYxw==
X-Gm-Message-State: AOJu0Ywzvx4JmM5Oy+X9454khmz9ygogh+hVlr/r7YgH15YC1l4LN2ey
	fElHEfDTSAeWk+BajQxB/7Vec5uSKKZaW3DDNqg0LtLsLzbUOSL1/BMBdg==
X-Gm-Gg: ASbGncu1SIDU4yQrfQlkNU1DyQam5zGvsgndGev9RWBUj9QmH6Na22PHZ5nkK11lHl8
	0HVE9b5ebdKIeynNpm8TV/HkX+4BAZbdgYLLxdWW75NDjr7XwBzBdI2/JF5vOXGbfYJZ//eY1Hj
	odRV/I6EDruRsT3TUDSGUbR13LYuOXrkLi9w9LMtcYIIAIjpfs+2J7WnlzpSEKiEa1xjNOE98UZ
	Ec/xU1ZepNn7mCmk7oXXOOL3jBokax7xYZ/UnHYCyjzcNN79tDMZGFJo2UCO8ajLyx5s6BBp7Y8
	uHnJF+ibwdH7fFi9edp4cojayEe8U1A24Cvlsir+ElNcc1njTwr3k4Lrs9EVcGteR+gF0g==
X-Google-Smtp-Source: AGHT+IHF+l6SXhoBO7f8zz1v9KFk4VNpNXq+6NBpsO+BwvB3023Vb6QhTDcxUikYRYu9SP0v9+NhAA==
X-Received: by 2002:a17:903:98c:b0:216:356b:2685 with SMTP id d9443c01a7336-21dd7c4e433mr55030065ad.11.1738160247123;
        Wed, 29 Jan 2025 06:17:27 -0800 (PST)
Received: from [192.168.1.164] (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3d9c952sm101391985ad.2.2025.01.29.06.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 06:17:26 -0800 (PST)
Message-ID: <65c39ed9-5473-4d8c-a289-77ecb7012dba@gmail.com>
Date: Wed, 29 Jan 2025 06:17:26 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] netdev: avoid PMKSA for fullmac drivers
To: Martin Petzold <martin.petzold@tavla.de>
Cc: iwd@lists.linux.dev
References: <20250128180438.65113-1-prestwoj@gmail.com>
 <e7df49cd-3db1-42c4-bb65-aaca630d685e@tavla.de>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <e7df49cd-3db1-42c4-bb65-aaca630d685e@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Martin,

On 1/29/25 12:54 AM, Martin Petzold wrote:
> Dear James,
>
> Am 28.01.25 um 19:04 schrieb James Prestwood:
>> The fullmac drivers need additional support to correctly work with
>> PMKSA. This can be disabled via main.conf, but to avoid extra user
>> configuration avoid the use of PMKSA for fullmac drivers
>> automatically.
>> ---
>>   src/netdev.c | 22 +++++++++++++++++++---
>>   1 file changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/src/netdev.c b/src/netdev.c
>> index 2a6d94fc..7af3c39a 100644
>> --- a/src/netdev.c
>> +++ b/src/netdev.c
>> @@ -1518,7 +1518,8 @@ static void try_handshake_complete(struct 
>> netdev_handshake_state *nhs)
>>             l_debug("Invoking handshake_event()");
>>   -        handshake_state_cache_pmksa(&nhs->super);
>> +        if (nhs->type != CONNECTION_TYPE_FULLMAC)
>> +            handshake_state_cache_pmksa(&nhs->super);
>>             if (handshake_event(&nhs->super, HANDSHAKE_EVENT_COMPLETE))
>>               return;
>> @@ -2455,6 +2456,19 @@ static void netdev_driver_connected(struct 
>> netdev *netdev)
>>           eapol_register(netdev->sm);
>>   }
>>   +static bool netdev_handshake_can_use_pmksa(struct 
>> netdev_handshake_state *nhs)
>> +{
>> +    /*
>> +     * Do not use PMKSA if this is a fullmac driver as they need 
>> additional
>> +     * support (SET_PMKSA) in order to function properly. Until this 
>> support
>> +     * is added fullmac drivers will not utilize PMKSA.
>> +     */
>> +    if (nhs->type == CONNECTION_TYPE_FULLMAC)
>> +        return false;
>> +
>> +    return nhs->super.have_pmksa;
>> +}
>> +
>>   static struct l_genl_msg *netdev_build_cmd_connect(struct netdev 
>> *netdev,
>>                           struct handshake_state *hs,
>>                           const uint8_t *prev_bssid)
>> @@ -2473,7 +2487,8 @@ static struct l_genl_msg 
>> *netdev_build_cmd_connect(struct netdev *netdev,
>>        *       0 (open) for FT Initial Mobility Domain Association over
>>        *         PMKSA caching
>>        */
>> -    uint32_t auth_type = IE_AKM_IS_SAE(hs->akm_suite) && 
>> !hs->have_pmksa ?
>> +    uint32_t auth_type = IE_AKM_IS_SAE(hs->akm_suite) &&
>> +                    !netdev_handshake_can_use_pmksa(nhs) ?
>>                       NL80211_AUTHTYPE_SAE :
>>                       NL80211_AUTHTYPE_OPEN_SYSTEM;
>>       enum mpdu_management_subtype subtype = prev_bssid ?
>> @@ -4053,7 +4068,8 @@ static void netdev_connect_common(struct netdev 
>> *netdev,
>>        * If SAE, and we have a valid PMKSA cache we can skip the 
>> entire SAE
>>        * protocol and authenticate using the cached keys.
>>        */
>> -    if (IE_AKM_IS_SAE(hs->akm_suite) && hs->have_pmksa) {
>> +    if (IE_AKM_IS_SAE(hs->akm_suite) &&
>> +                    netdev_handshake_can_use_pmksa(nhs)) {
>>           l_debug("Skipping SAE by using PMKSA cache");
>>           goto build_cmd_connect;
>>       }
>
> I also still had problems with the brcmfmac driver and IWD. It was not 
> finally resolved. I will try to check again with this patch.
>
> I would really appreciate, if you could have 2-3 brcmfmac devices 
> running in your testing environment.

Happy to receive any brcmfmac devices you'd like to send my way ;)

Thanks,

James


>
> Thanks,
>
> Martin
> tea
