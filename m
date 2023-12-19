Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D30819BDE
	for <iwd@lists.linux.dev>; Tue, 19 Dec 2023 12:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bu6u4cTs"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5cece20f006so36758917b3.3
        for <iwd@lists.linux.dev>; Tue, 19 Dec 2023 04:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702990649; x=1703595449; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Iuh+7Xdfh9SIu9RUb6+V2XCCMQ74+o6eZcvQu2P2lXM=;
        b=bu6u4cTsTycPlUkYVh7Hukag/f91TdZ+kFToF0UgjOcNe1UxnWQSsNuBTgPeGl8MTR
         DQYk/6FPoFrG17DA1KbGxT5imeAM6NyWIWXW1eRQo7VsqKeBYlRZDk0swI+foS51heJI
         op11hEmzhg+DfcAmCddCF7+fQcUVRMnAi9GX1bB2emmioSaLepfjpizuQh1DPBY6ZHTa
         H/fUTdRUGTnNuPypB35DYGSrn9PiUUNUEQJ9cPL+zmF0XVthzed120IFEufrBPXQciOo
         kBMxf6JAv7H4LR/CtrLdk7oadfQCagwQryynDYQHxnsj04jaiupnr3RYc1AAF5tw+NO/
         UFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702990649; x=1703595449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iuh+7Xdfh9SIu9RUb6+V2XCCMQ74+o6eZcvQu2P2lXM=;
        b=DptqHHVLmgHtm/GgL/CVs2bfqbWDmHT+gUgsRKh3VtlDUDqmDxtNJcunyJn6oc1Z9+
         qzHHMLyudkGTTAdhJYk0qcJDefKQhcxSsAiK50AUl4hOtxaoTPiPtl4PONFV5pC688er
         UYtweZGnK/RTZwwetmYPDXS+hR07PpE6HHhe9ay/Pgr68OmPU4M0SqrgYTt6IGHBxEH7
         R8AJXC6FDdvlNhO7FCyeveH63i2unZ3J80FNv/rmyEz2FJ6HJob/UG2QMMxSvm4LlfoM
         PpbjRaMrHtfVsBRIBZ3/CJl8ndnzCVSy0H9Iy3HICK1xE8eeHLAdGIzPrZ9kJXB5xAKx
         m78w==
X-Gm-Message-State: AOJu0YzjOAHebUKsOSRi6WDVQR1Sykp0CBrvd2vWKhD1wNBJK1qS3V0e
	BLIK6YzScClajp3qk5U9ylHWDwIBLKU=
X-Google-Smtp-Source: AGHT+IGC3JadO1T3tJ85dkt0isuuf3mBrri95gXGnBiFYpcnbi/uznfl6u+sLxJSGKRImafiHU7SYg==
X-Received: by 2002:a0d:e257:0:b0:5e6:e9d0:94d5 with SMTP id l84-20020a0de257000000b005e6e9d094d5mr1804583ywe.1.1702990648657;
        Tue, 19 Dec 2023 04:57:28 -0800 (PST)
Received: from [10.100.20.201] ([50.225.159.98])
        by smtp.gmail.com with ESMTPSA id o5-20020a817305000000b005cd9cdbc48dsm9693429ywc.72.2023.12.19.04.57.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 04:57:28 -0800 (PST)
Message-ID: <ee339749-46cd-4927-a3fc-ff80924a5f70@gmail.com>
Date: Tue, 19 Dec 2023 04:57:25 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] knownnetworks: network: support updating known
 network settings
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231218141250.202157-1-prestwoj@gmail.com>
 <6ac609fa-0540-479e-8ab3-387b0cab24cb@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <6ac609fa-0540-479e-8ab3-387b0cab24cb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 12/18/23 8:31 PM, Denis Kenzior wrote:
> Hi James,
>
> On 12/18/23 08:12, James Prestwood wrote:
>> Currently if a known network is modified on disk the settings are not
>> reloaded by network. Only disconnecting/reconnecting to the network
>> would update the settings. This poses an issue to DPP since its
>> creating or updating a known network after configuration then trying
>> to connect. The connection itself works fine since the PSK/passphrase
>> is set to the network object directly, but any additional settings
>> are not updated.
>>
>> To fix this add a new UPDATED known network event. This is then
>> handled from within network and all settings read from disk are
>> applied to the network object.
>> ---
>>   src/knownnetworks.c |  4 ++++
>>   src/knownnetworks.h |  1 +
>>   src/network.c       | 27 ++++++++++++++++++++++++---
>>   3 files changed, 29 insertions(+), 3 deletions(-)
>>
>> v2:
>>   * Instead of bothering with individual settings we can just use the
>>     new l_settings object. This would still prefer agent-obtained creds
>>     set into the network object but also honor any new settings written
>
> Ehh, I'm not so sure about this. handshake_state_set_8021x_config() 
> does a shallow copy of the l_settings object.  I think eap state 
> machine will make copies of the info it needs, but...
Ok, yes this wouldn't work as-is then, but we could clone it instead.
>
>>     to the profile if there is an ongoing connection. This is a much
>>     simpler approach (unless I'm missing something). Only questionable
>
> Also, netconfig_load_settings is called very early in 
> __station_connect_network, so even if you overwrite the settings 
> object here, it is probably too late to take any effect.

For this case I'm not sure there is any difference. Keeping the existing 
settings or replacing won't change netconfig once 
__station_connect_network() is called. We would need some changes in 
station to load the settings again after the connection. I'm not sure 
trying to solve this specific case of settings changing _during_ a 
connection is really in the scope of this patch set. I'm also not really 
convinced trying to fix this race condition is all that important. Its 
not really a "race" per-se, but more of just how IWD works. The profile 
is loaded upon connecting and those settings are used. If you swap 
out/modify the profile in the middle of that I don't think anyone 
would/should expect those changes to be taken for that ongoing 
connection. That's my opinion on it anyways.

What we do need is the ability to update settings on disk if IWD is 
sitting idle or connected. Currently if network/network->settings 
already exists its not possible to update unless IWD disconnects.

You mentioned copying over all settings except the security group, but 
this wouldn't handle the case of DPP (or anything) updating the profile 
with new credentials. I think we need the l_settings object to be 100% 
synced with whats on disk (but as you said, 
network->psk/network->passphrase shouldn't be altered). This then means 
the entire settings is copied, so its much more efficient to just 
replace it. Does this make sense?

Thanks,

James

>
>>     piece is what to do with the Security group. I hesitate to skip it
>>     because its what we have on disk, but it could mean the network
>>     object isn't synced with its settings. But I'm not sure this is
>>     any different than what we have today, if a profile is modified
>>     during an ongoing connection its settings (including security)
>>     won't get updated until a disconnect/reconnect.
>>
>>   * Remove frequency sync on UPDATED event
>>
>
> Regards,
> -Denis
>
