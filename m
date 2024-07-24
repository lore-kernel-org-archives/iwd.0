Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD55381C7
	for <iwd@lists.linux.dev>; Wed, 24 Jul 2024 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721834272; cv=none; b=QGnG5/vGpY2g5gdVfxySjSmu1+q7yzdghVhhpszQOvwAvjH5vlfUDtEGdrLfOUA1BQZRSrr+fXnNixG9fNzQnS2YccP0UOkbXwMAduIaRmaJNoTVFAEu+OgS2Xe7UqOg0pLAFB9vop5VgnhZGlazS7ByeJeRpa0ehGTUa+cZ/pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721834272; c=relaxed/simple;
	bh=VKtwXDPjG34mGkNPnViGJsTCDMDg/dasuTDTPXFVBsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q3PcnPuyAA0rMfKgdoVgYoym1czwmoPmnXVvHh+c+jyIEZ3BQihlIpXinFBkI9/QuOfn6pvOfmqymYWwymnuEWbzBUE+BimwZIyUPAI3NGqcq3EBbkpw5dKC+hh+WZNfHEyPTYpwypXh1e7W0kmu/W/I17Wu3Ns++HOHFiwBWCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luhNitBV; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luhNitBV"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-447fd75f9aeso34671171cf.1
        for <iwd@lists.linux.dev>; Wed, 24 Jul 2024 08:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721834270; x=1722439070; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gb+/yF+5tOC3GJW93jUKvSvA3XGD4zE3N25R+Y5hhTk=;
        b=luhNitBVstTrsCOlFBwfrspfPtbFX3fW1fThT2NdGPTpnpC8jjeh7sUpqPvVYkQ0J6
         mF6pA+Rw8CFNv+fiHM8CZLkpgT8onukXfXsYbsOv62L2kywCDiG8zLz9FIWffTXUxqX/
         IhCtLyJ2qiQz+XG2CoqPDp308RQqAVdz/v6270u8Myc6/yA+1tKP/K3LrzKTC5vBzqIh
         c0jjDQE50WS/1u/2hMwOcuzgWyKova+an38DFMdTdeloBNQciohvogYwKs9RpaOMUbmf
         K3j0xMysDgF98IxyDUxCPrNHo3fcZKZi/4bKNqt+87fjseJYgVmfnz7h5EUWfExzNcM2
         uk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721834270; x=1722439070;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gb+/yF+5tOC3GJW93jUKvSvA3XGD4zE3N25R+Y5hhTk=;
        b=faKvMJzbfLFJj9wrQdv2pXRUGWlb4MwxH9b6Ip9qop5htOMLh8x0y7GiYX5j/r/pvn
         xQqEtELk8+79keOxRwBwXJtbyePp6o1vj060bPX5OIdkLud/5pikPX0gjvB5LeP6KmJR
         nYYlwC0AJJwKGZKZaRnbEfdGnTD1pNexb1kX4EOZoXIHRvhSQ0EOffc/XU2BvSZv8Owp
         asZ3/FYwctzaqCXMa4f6ksQGpiBtqErPOrANGlrNp8+2ciVaxoIcCFYXrrtZj5Y7IEGc
         FRaANuLhm6pKBchT45FSygAhRakwsLII9hp6e7emohP3vx6kJm4FDhc0QrkjN3W3XNed
         s4wA==
X-Forwarded-Encrypted: i=1; AJvYcCX0P9zKZQ8/UsxrbXVMpAKGCqWJMMm6v6F1ZPQ5orGH7bqx8p0rtu/t3AEcZQ6tVPMF8jl04fo+U1TLYXOzugqSboRr
X-Gm-Message-State: AOJu0YwULmnEPOFywSAGB2vtqs2Hsk7Y7p7jps6dd4neCUhvysXr555J
	EXE20DFmQOKMmQjtJH+dDq92es2PpwV3lwe4Ej0NHp5or4Ul3MKpBTw2+A==
X-Google-Smtp-Source: AGHT+IHrO2vHbnMO6dqz4SurJbAgYSzHw0Fku2yxqdc4lZTOx9CjP3k9C8dB7XpYdDd1/VJfxI1yaQ==
X-Received: by 2002:a05:622a:48e:b0:447:e3da:8018 with SMTP id d75a77b69052e-44fd68389d4mr23441751cf.8.1721834270366;
        Wed, 24 Jul 2024 08:17:50 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9e3b62e8sm54186771cf.74.2024.07.24.08.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 08:17:50 -0700 (PDT)
Message-ID: <5270e5fa-e1e4-472b-8598-3093edfcffea@gmail.com>
Date: Wed, 24 Jul 2024 08:17:48 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] dpp: explicitly disconnect station if enrollee is
 started
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20240722182932.4091008-1-prestwoj@gmail.com>
 <20240722182932.4091008-3-prestwoj@gmail.com>
 <a1b40f90-e69b-4b70-80ef-c228fe54be94@gmail.com>
 <09ae7769-63fd-4c61-8cfa-a40dca535c59@gmail.com>
 <683fd9f7-f724-4abf-aa6d-883d12b57aae@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <683fd9f7-f724-4abf-aa6d-883d12b57aae@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 7/24/24 8:15 AM, Denis Kenzior wrote:
> Hi James,
>
>>>> +    /* Unusual case, but an enrollee could still be started */
>>>> +    if (!station)
>>>> +        return false;
>>>
>>> Function signature returns int, but you're returning false.
>>
>> Yep this is intended.
>>
>> true for a disconnect has started or is ongoing.
>> false for already disconnected
>> < 0 for a fatal error (i.e. station_disconnect() failed)
>>
>
> The typical convention is:
> -errno -> error
> 0 - > success
>
> You can extend this to mean that 0...INT_MAX is a success and return 
> value simultaneously.  Mixing integers and bools is not what vast 
> majority of people would expect and should be avoided.
>
>> If this isn't desirable we could do:
>>
>> -EALREADY for a disconnect is started/ongoing
>> 0 for already disconnected
>> < 0 for a fatal error
>
> That would be better.  Another alternative is:
>
> int dpp_try_disconnect_station(struct dpp_sm *dpp, bool 
> *out_disconnect_started);
Ok, I'll do one of these instead.
>
> Regards,
> -Denis
