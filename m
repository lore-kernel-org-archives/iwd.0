Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47788002E
	for <iwd@lists.linux.dev>; Wed, 24 Jan 2024 18:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706121864; cv=none; b=XSSMt71spt0LgXM7puHrg2rGeCxFveBKiaGwkH5TKNHIQRFANy0tsyABvoS+4F6v+zkmP5fFLXDivjSjiiMv6ILqy3T5Paf+OoEXACKrSfG7+0EELUk8SpLk6SodQ9VNbvMseQXSeCVSFVKKlL5OKfsuCH7qzs+w2Qe/cYZv5Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706121864; c=relaxed/simple;
	bh=MlSpXKvj+jrvITLNekCxmCGwMkl132qQbamL3YpbsH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LbZ2/a9fiOlYHaGd+NXXX7OHYIdfHxOpZjeoCXeEdPJp+vp3lZwp5jo3Bja6t9yiidj+a7VzRAamlH52+/3iMdhmVleNq1rKC53IKif320hKn4P6JPq8GvqkVPAOXVye77cEL/yfCpxh1Toz0iMkFukGB1ENGjg5gAJPBnhbWdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+aQA1cQ; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+aQA1cQ"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-21433afcc53so2363377fac.3
        for <iwd@lists.linux.dev>; Wed, 24 Jan 2024 10:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706121862; x=1706726662; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sSkI8lI461SeI3TrUOnCfhFpfh+H6d3N3OLbY0By2vs=;
        b=U+aQA1cQ3ShtKygKkeaw3hwll6B9MyoiS3CkjebAPQgpRjxFih/Bf34QKrZ7lvPL7g
         qzqKvriH/rxtulvggEx2ZLKQPQ6yvqSTHnQ/yLSrQxghUy6MyZa8AMp4d7VZ5kJtW5ew
         JBVQa8MutOBmE+89+mJg+ReU3EQVANhU459iWeplIj73nMvdF03r2l3T9MegNp/DkbsD
         wT0to6zYMb2X0TdG3oaEYMjRhEvp5Uu7IuPTBxTQUihkIvtu9CbIMotcejC2LJKf1Hm9
         dY6RPBzXLVEIs+fmobveGfzwCky939rPA+I4ssXXjlG5FMzmeqAFGgFsweLqXe/drzdJ
         kq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706121862; x=1706726662;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sSkI8lI461SeI3TrUOnCfhFpfh+H6d3N3OLbY0By2vs=;
        b=mhNEFFUwdy6a/Xc+zmwD0xAPdzWNpWErHREeS038T+EXfd+aWvfdAVzmHCcdR6uefS
         OcfTZ1k86nrD8EulSst44DO07WBJwcRsQ5XXIYkskK9AoNIq57lv5PCNQJ2axqUmrjtW
         Ku1JTHoRFm86r5o8JWWd1jh25Yxy40mWIOHb9Rt9OkkUq8jnAPpw1909MTO+/NmkNIre
         QH+Kd5XkCtsVBK3ONv05tqcdBkxz/MMkD/kiqwTA1POVrtdFiJ+459igwCmusXhSbty2
         vzFHk8Dryu6RltN0YQ0qpZPgNCS74/L3cO0arQjYA/TLTLSFz/LQx27w6XbIZHX/1kVe
         fNNA==
X-Gm-Message-State: AOJu0YzYCopPi/patWgxt6Sqg1iAmgOzKmXF4evwGQdA8OAU62+12OLE
	+g17yvDQaBpWeiVK4KVwFtJsJiYE/45800wDFhFBJKXOUusBTzqSdxlSbV7U
X-Google-Smtp-Source: AGHT+IHhvSGYUwqoRFIWUjV7a2cN1JMNpWX1BLQ5BNZMdRZai8Qp2gm+VDlhI1v0xCZCxGAF9BDfHQ==
X-Received: by 2002:a05:6870:d38b:b0:214:292d:69b8 with SMTP id k11-20020a056870d38b00b00214292d69b8mr3844524oag.91.1706121861879;
        Wed, 24 Jan 2024 10:44:21 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id m13-20020a0568301e6d00b006dbfafc2049sm2685048otr.30.2024.01.24.10.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 10:44:21 -0800 (PST)
Message-ID: <8015796a-e94f-44bc-a01d-0339b1a156a2@gmail.com>
Date: Wed, 24 Jan 2024 12:44:20 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] knownnetworks: sort known frequencies by BSS rank
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240124134001.20453-1-prestwoj@gmail.com>
 <20240124134001.20453-2-prestwoj@gmail.com>
 <703a48ba-41f8-4104-bb1d-6b017ae76e15@gmail.com>
 <ac057182-4b8e-44ef-ac32-9b039d13e45f@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <ac057182-4b8e-44ef-ac32-9b039d13e45f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

>> Perhaps an easier way to accomplish this would be to add known frequencies in 
>> reverse bss->rank sorted order.  That way last seen frequency with best ranked 
>> BSS would be first?
> 
> I'm not sure I understand, how would this be any different than just reversing

Well, right now we maintain the least recently seen frequency list in a very 
simple way:

- When scan results become available
	- Walk the result list (which is sorted by bss_rank?)
	- Add each result's frequency to the frequency cache
		- Remove any matching entry in the cache
		- Add it to head

Since the result list is sorted, the top entry in the frequency cache is the 
least ranked.  This doesn't matter for small networks since there would only be 
a couple results.

What we should do is to add the frequencies to the frequency cache in reverse 
order.  That way the highest ranked bss is at the top of the frequency cache.

Hope that made sense.
  Regards,
-Denis

