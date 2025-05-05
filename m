Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DD441C63
	for <iwd@lists.linux.dev>; Mon,  5 May 2025 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746449431; cv=none; b=KhPUlP/1xCjzEZpua5iz7Txo9kVtEgzNdBAiuy7PrnAqounSTnWJNMxqZfxDJ67XhGZXmjydBBaCaWsdmIDRcNaCmGM9QgrJqOUXNHqrD8ZKCTuDvh+kA7cZ+bPElf2LMrfwa6Mo9eI28fIzZXcfgIoyxk2qxP4BX/AWmFrzE3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746449431; c=relaxed/simple;
	bh=hYCuFmu3w1YYWhqYx5ESBlxKxZhxVn09NY013gMgKCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lV6u9/YS70uVZ0z6dKdcEa0A/SJIr2lmB3m9bzcmFKN/zUEZD+e/tJh+Y6TB0QGIDIEb6L2FpXIjiuL6O1SL+AXkE/0sOjWq2dcQqxI2Ic6UeSY6hs49oSSX4MkgJkIezorfBTQrGQIgVAc7+qk0Ak04rk7HRr3DWtPW3rqw8Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9uzP2YC; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9uzP2YC"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22e09f57ed4so38642995ad.0
        for <iwd@lists.linux.dev>; Mon, 05 May 2025 05:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746449429; x=1747054229; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zxf4mLHaaXMrsJ8+5UK35n6cfcRbFFjuRLROGp7Zttw=;
        b=h9uzP2YCTEXzEOAVww8N3kJdgEE42Loj5W58Gr9pq2SAnu9+9LoMsWu6D3i9l2XwDn
         bhUSRVUSWqexH8liMLddalK4hETNDOZ4nC3rGXHZFbSmKTntRpNm3T6HpuqgJ86Z8AI/
         jskI4BJJ4tEfrfvhEXNe8g2Z0T7U/5WGRn1jY5stdwzqPjmN+mSNUZIRgwtXgT4Cl33q
         OG5C3TlXhBI7asIvJLQi7vk+tpE3RZQwqwHTOWRM8Pwp8V2caP4UkbZWfekkHiTMXw0t
         vCcB6/nPTeOruwnG08hWGaalEZ6VA8cuBD4Z2Vde6YpeRhKzQYmRX6M/h0bHuEahFyL/
         YFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746449429; x=1747054229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zxf4mLHaaXMrsJ8+5UK35n6cfcRbFFjuRLROGp7Zttw=;
        b=aJ0UqX30WgakzUfHqpYb0p0bKbskJljRpYNx8WE2EEhNnMSzOHr1OQv8WkUqe/mPuj
         jDe64ppCAqo+bHLHqBd1oYDetbfH0uphro1J72lf8FOM+Rdy8WNiFXooTQL2OKte34HY
         nwkySZhaNG3wTKhrY8Qjtb4iBrRkm7AU+v0Xc4H2r07bZlobH2zrAfTVcHc5YoYS8ele
         z7ncaUVPODArjwHXALKDiAck7zShNBsjVh48IOqBXgW6y630DVYAwawb8KXHUPvysEdf
         L9rCzXJElZhdU2Kj887AcKo6MyAH0p+2aYUXw+TfW7eyruJ7cBn7971zp41iZWQPNRkT
         yrCg==
X-Gm-Message-State: AOJu0YysAdEpjGZknlIE/C1PiHkYQjbPsUYQDklRVwtKtzqNNZFlQo6V
	QEgxiKCR++AZ7buTFq53yUpLPvO0s1Ta8LaeyBVe0qe6VmRz+/D0I3PrEg==
X-Gm-Gg: ASbGncueWO53NZl2hEeFxUZJvoo0U8zw8BkjW8Eyc7/mb38lzDzOpQ4k1VKMzvXB8E5
	ni5aOsAP9dMRy/WW0lS5Y1BtZbe4akk/UZCKrE3ptqgClOTMJ8+BN7PS203QFngK/bpbVOg7GGE
	f0ymJR1IEB+9c4wHW+BOWV3cGFdvV20RDipLK/mEFDvUrqu8UWie+OBEr0C2T6OnNpW3Un/vS+6
	jnyzclWvxF+P3kHLwDUvbbIvOvhrR+Rceb47sXozX8YwDULv7rl8DD90xIYJabQ/nZHRsVd4Bec
	hNHmpin0pDE7C1HFo4XTiPdEq4kTDDbYW7xS1AbJGliNe5PRc4PTtcvplwJu3M5Mtj/jr3X4KKH
	872wzlUGN36HDwo0cX6iLpsinTm8qlA==
X-Google-Smtp-Source: AGHT+IGNpwTMa+4jji1WoZvAOXDUnmKaLLJGHELuXQMdRILGrVJOMwLmUsCe17VqD3TjSyKoNfDpLA==
X-Received: by 2002:a17:902:ce0c:b0:221:89e6:ccb6 with SMTP id d9443c01a7336-22e100ef25amr214539455ad.25.1746449429170;
        Mon, 05 May 2025 05:50:29 -0700 (PDT)
Received: from [192.168.1.164] (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e151e995bsm53636225ad.69.2025.05.05.05.50.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 05:50:28 -0700 (PDT)
Message-ID: <b640af88-c952-4cc5-8339-8a1e7cbf4658@gmail.com>
Date: Mon, 5 May 2025 05:50:28 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] unit: check cipher support and cleanup in test-storage
To: Marcel Holtmann <marcel@holtmann.org>
Cc: iwd@lists.linux.dev
References: <20250505123540.281773-1-prestwoj@gmail.com>
 <80DB75BF-0D93-4432-879A-AFAC76B4BE8B@holtmann.org>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <80DB75BF-0D93-4432-879A-AFAC76B4BE8B@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 5/5/25 5:39 AM, Marcel Holtmann wrote:
> Hi James,
>
>> The __storage_decrypt API requires AES_CTR so support should be
>> checked before running that test. In addition storage_exit was never
>> being called which leaves unbalanced mlock/munlock calls.
>> ---
>> unit/test-storage.c | 11 +++++++++--
>> 1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/unit/test-storage.c b/unit/test-storage.c
>> index c40518e6..765d9967 100644
>> --- a/unit/test-storage.c
>> +++ b/unit/test-storage.c
>> @@ -44,12 +44,19 @@ static void test_short_encrypted_bytes(const void *data)
>>
>> int main(int argc, char *argv[])
>> {
>> + int ret;
>> +
>> l_test_init(&argc, &argv);
>>
>> storage_init((const uint8_t *)"abc123", 6);
>>
>> - l_test_add("/storage/profile encryption",
>> + if (l_cipher_is_supported(L_CIPHER_AES_CTR))
>> + l_test_add("/storage/profile encryption",
>> test_short_encrypted_bytes, NULL);
> just use L_TEST_FLAG_ALLOW_FAILURE instead.
Ok, new way of doing things I guess.
>
>> - return l_test_run();
>> + ret = l_test_run();
>> +
>> + storage_exit();
>> +
>> + return ret;
> I really prefer we keep “return l_test_run()” as the basics on how test case are run.
>
> Just put storage_init,storage_exit into the test case itself. I would just do system_key_set = false in the exit function.

I'm fine with this, but its actually not possible to perform the cleanup 
after a failed test. If we want to do this we need actual cleanup 
support in l_test. Looks like we'd need to add a destroy function to 
l_test_add_data_func().

Does that sound ok?

Thanks,

James

>
> Regards
>
> Marcel
>
