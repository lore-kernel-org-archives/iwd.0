Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A4547F5B
	for <iwd@lists.linux.dev>; Wed,  6 Dec 2023 19:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dn3KD0SY"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d0c4d84bf6so1107915ad.1
        for <iwd@lists.linux.dev>; Wed, 06 Dec 2023 11:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701892389; x=1702497189; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gdxBwWa8uMR8a9hhg/ebB4x6a4BZOZn7Wl8vA96TpUQ=;
        b=Dn3KD0SYyrljZUKMpvOtLaVhXr/oESRfYmkTFsNYHEVwm/utoruFWE4fVbPiftlu9w
         dozx7S6fxfEhz94BpaTnpnd6imzL8NphiYZU1AScfJG/+XXA7uXOjrV8sl8c/huhS3bR
         xi9LDc9cUrNK51GKOF/PrRzxrjGHrCq0nxmSKzKYf+qINwSdQrWVvqIMWSrlhIXJNPH3
         bYqely8oBbfsen4AxhkZv4/38N8trHsB8o9jnHN6OPDi/XZnxu9ED/y9AzRSF/r9I+3z
         07Z2DwpXU1qr3o8s00/NlDCYAp63UGYirM+7WKBzSJMWajSBFUqJRiB3DZJ6ELoQAoBN
         rvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701892389; x=1702497189;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gdxBwWa8uMR8a9hhg/ebB4x6a4BZOZn7Wl8vA96TpUQ=;
        b=iEtSoQ2XqSRX4g/n7MR3wiZ0VvmutAFXuEEygbe1ZwB88g6Ftkh2hWjayf+MLEUNsJ
         5MfSHebdbUM/pO0ScOrFQhOW3b4oLJIyAXUudXfTHAEvTC07OS+OPBndP13UBr8WTMJv
         yB2kkWvfQ25QCUdVM0Owei+lKTlxdRGgSP0YfqmD22LQ1YDsuPsxx74+3NZlMo6G+OOp
         l9h+30ustb8mneIxPpN0GAPXMlmpLh2iRbzw0KvM5FScnqneannAYiiyNIAqvbGt47n9
         zHHbCQv2AM7eglLXkwRg9QjtoGVs9tPCQjyy+4+v3eV0fJBj9vNSPgOfr/L7SHusuchk
         dkzg==
X-Gm-Message-State: AOJu0Yy70cNg/TxJCeKoh9QA3l9ALJ8B0OPGNz5vaIv0vF8gZOn0ujWe
	rHBeNi/ySwo76+EyktnJ/I6bCdMCC04N0w==
X-Google-Smtp-Source: AGHT+IGbDd/0UPlMBWwDafTKyr8Ok+ddOW8vhCFmrdbrA6U1W9YuL/jCmQ5DE1xiwWNfXgL/5kOdGQ==
X-Received: by 2002:a17:902:e5c5:b0:1d0:90bf:cba2 with SMTP id u5-20020a170902e5c500b001d090bfcba2mr1034967plf.73.1701892388658;
        Wed, 06 Dec 2023 11:53:08 -0800 (PST)
Received: from [192.168.254.82] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902f7c700b001ce664c05b0sm203714plw.33.2023.12.06.11.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 11:53:08 -0800 (PST)
Message-ID: <69446eba-89cc-4279-8e47-151bdb6798b8@gmail.com>
Date: Wed, 6 Dec 2023 11:53:07 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] network: add support for SAE password identifiers
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231205154647.1778389-1-prestwoj@gmail.com>
 <20231205154647.1778389-4-prestwoj@gmail.com>
 <03c0874e-0f64-493f-b9c8-cb302045938c@gmail.com>
 <6faf5c3d-cb78-47c0-a3d2-aec8211e79cc@gmail.com>
 <69055eff-521d-4e2d-b3c9-c98bb7ba36fb@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <69055eff-521d-4e2d-b3c9-c98bb7ba36fb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/6/23 11:44, Denis Kenzior wrote:
> Hi James,
>
>>>> Loading the PSK will fail if there is no password identifier set
>>>> and the BSS sets the "exclusive" bit. If a password identifier is
>>>
>>> I'm not so sure about this.  The trouble is that this logic is 
>>> sufficient for the initial connection, but isn't sufficient when you 
>>> consider re-association.
>> Your right, roaming would be entirely broken between BSS's that 
>> mismatch using password identifiers. Maybe even hunt-and-peck and 
>> H2E? not entirely sure. We 
>
> Well, ReAssociate would just use SAE passphrase directly, so it would 
> work in theory...  But it is a bit of a strange case.
>
>> would need to re-derive the point for each roam, like in 
>> network_set_handshake_secrets_psk().
>
> ??  You mean SAE-H2E with password identifier for BSSes that report 
> exclusive/in-use bit and SAE-H2E for BSSes without?  Or something else?

Yeah, I'm talking about multiple H2E BSS's that set or don't set the 
exclusive/in-use bits. Maybe it would be ok actually. I got concerned 
when I saw the points being set into the handshake in 
network_set_handshake_secrets_psk() (which happens on roaming) but it 
looks like this is only used for initial SAE association. Maybe 
roaming/FT would be ok? But this is all moot if we just bail early if 
the password identifier setting does not match the BSS's capabilities.

>>>
>>> This likely needs to be taken into consideration much later, when 
>>> building the actual handshake state.
>>
>> Yeah, we'd need to move this into network_set_handshake_secrets_psk 
>> and rederive the points. And actually if we do this storing the 
>> points in the network profile doesn't make a whole lot of sense 
>> anymore since its being rederived every time.
>
> I would hate for this to be the outcome.  Re-deriving the PT is pretty 
> expensive.
>
>>
>> Alternatively we just keep it how I have it and tell they user 
>> they're network isn't configured properly :)
>
> I think it could be argued that if PasswordIdentifier is set, then any 
> BSSes that are not H2E/do not set the in-use bit are not connectable.
This works for me. Much easier and will enforce a properly configured 
network.
>
> Regards,
> -Denis
