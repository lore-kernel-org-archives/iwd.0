Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A776217CA1C
	for <iwd@lists.linux.dev>; Thu, 30 May 2024 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717074629; cv=none; b=hEGs4oTnCoUhM6PYDTp0f5pDqIIsjslS3jF26NBThSvdwFCz9wgLeOFWdrOrBiOmS3mlTIN62Elotq1KnH1LtP0u8YAprfeTirKS14eT6XDV1qbf599JohCB9yHZp6g+PJaBdiPmSYYOcXDZBA6c+Lx1vYl2R6jgIAWRjiglM/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717074629; c=relaxed/simple;
	bh=SJAjf0ew2+/w+4DgKycldGhbgtKhXLtWnhiJptxdvuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Jly8JmGv9+HAAmbws3nB092KlEnprZDMDTbVicO9GBCDjoM718cCNCR29zxeM6bwlYZk4OhwnuTceKedv/ywhsqe5C25Q3OyhCE030Yyu+ur+Flxy5vXY/8YXOjxCPym1wdF8ztnWiyTpFU9ryMcR9RNdeoC9ZtrOzHZ/aurgOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gs0VCji3; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gs0VCji3"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6ae0c4d23ddso4368966d6.0
        for <iwd@lists.linux.dev>; Thu, 30 May 2024 06:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717074626; x=1717679426; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bJ+ygwuq5e3tdI/VQWMHKLpu7JMgOZN9OQIdWPrI6U4=;
        b=gs0VCji3f+b/8qHNxE4ZhNT6yAiib7Wo97ZB46lr9WKe0oR2Ipqa/f9exwj5eWz/D5
         zD4L2gKF2IiLv9RlNKcqv2TrHGnkSDgUg9cR5EyVQuG12C0du94JeGVeLjyP0YfYp08V
         j3BtvB4dvHg2wQZ3cJ6RRxcIRuq+y4LUBNoUItsUIydHHv7qooLfO1C/Mpg+EhdhY0Tt
         SEZokCSXMb6KGaQ4580qSTEVenTlY6xTmyEG59ARAJqcHhCuNfUB3uRMJ8uFU9NAlHKI
         UXtrAeTdcSEkHfV7YA06AHyYMIWPkI7NhwlTqJUDAo+qBGNtU9WJQgObC5IVtyHGggmA
         /HMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717074626; x=1717679426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bJ+ygwuq5e3tdI/VQWMHKLpu7JMgOZN9OQIdWPrI6U4=;
        b=QnYpm2cPvFhpqhm9lU/lryiDOgH3jsjiVPbzvow5rHfkFO4C07DZmZItelsUtnshMB
         3d8YWMhE7FkZx+FuPXRVz3Au4WLZMQ0Zb6wEsXAFiKNo/eCz13zEuuW5ZxJNkhPELeXt
         DzGETQC2B8LNr1lP87yuTtAFIZYyqc7LstCZyBNAuEZ+eOvierIcqo+XiuXwpq4asvrJ
         NcOqwOA9IpnHu+FdNREd/RIQtZf8FaBVU5Yvkc+3FzWaOtOVioO7nqLYHQFx7n6v0JtI
         +wyhECLbQxMFwmgxBWzvCh3dJPL2EiJTn6FcyN06BhqH5dtcbAwIs2Q9jSa57K14d4AA
         VMHA==
X-Forwarded-Encrypted: i=1; AJvYcCWuOtqimA+txQNvr+NVNa6hvaJmRkY/maxxL12mzDuBcvIWHRld6KjrLkQDwMJmZUQH0MAcmcEnpmkg6cwnD8qG9agj
X-Gm-Message-State: AOJu0Yxa9x+9R16v/o488ONSbrqkiWTK+ku1FeP9h/NYQatRaAfhMy5J
	UtIBVXFvPHXYLA2oQPm96lNL7FT47eMy9IcA2mLePooa2HQA7IHVN9NFs9xa
X-Google-Smtp-Source: AGHT+IHssUGZUun7mZ5lC/8kzMj4dJg4JDDhOJnKe54EuvyDQavJIfBS47K4Q88qLshB+63CQPnXDw==
X-Received: by 2002:a05:6214:5b0c:b0:6ad:786a:5e35 with SMTP id 6a1803df08f44-6ae0cccfbb8mr16036986d6.62.1717074626317;
        Thu, 30 May 2024 06:10:26 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ad7a626a6asm42392626d6.63.2024.05.30.06.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 06:10:25 -0700 (PDT)
Message-ID: <5efbc990-b2fa-4bc0-864f-8d33b54407f3@gmail.com>
Date: Thu, 30 May 2024 06:10:24 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug when ttls start message is sent with tls_msg_len=0?
To: Laura Peeters <laura@peeters.gent>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <tpitoeMEXJxiLQiWJBuau4l3V6w-zuBf8bQVFFXHyArcn6AZBp4Mb5TLsDLxqMLgD_uGDNQ2eKnChB5wbsB82NZpb-KdBfCYrnVcm5kDFRs=@peeters.gent>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <tpitoeMEXJxiLQiWJBuau4l3V6w-zuBf8bQVFFXHyArcn6AZBp4Mb5TLsDLxqMLgD_uGDNQ2eKnChB5wbsB82NZpb-KdBfCYrnVcm5kDFRs=@peeters.gent>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Laura,

On 5/30/24 5:16 AM, Laura Peeters wrote:
> hi all,
>
> Recently our radius servers at work got upgraded to freeradius 3.2.4.
> It seems to be that in freeradius 3.2.3 and earlier the TTLS start message was sent without L flag (and hence without length set)
> Freeradius 3.2.4 on the other hand seems to always set te L flag, now the message gets sent with both S and L flags set (and length as 0). From my initial reading of the RFC, this seems to be allowed.

My interpretation is that spec is somewhat ambiguous on this... The L 
flag indicates the frame is fragmented:

"The L flag is set to indicate the presence of the four-octet TLS 
Message Length field, and MUST be set for the first fragment of a 
fragmented TLS message or set of messages."

So a fragmented packet with a length of zero certainly makes no sense at 
all IMO.

But this is is set in a TLS-Start message since the S flag is set 
(right?). I can't find anything to indicate if you can fragment a 
TLS-Start message, except broadly:

"TLS handshake messages SHOULD NOT be fragmented into multiple TLS 
records if they fit within a single TLS record."

I quickly googled around and this all appears to be a configurable 
option in freeradius. I can't link to the section directly but in this 
docs page [1] there appears to be a configurable "length_included" option:

          /*
           *      We don't need to always include the length
           *      (just in the first fragment) but it is
           *      configurable for compatibility.
           */

          length_included = eap_tls_session->include_length;

I'll let others comment, maybe we need a compatibility option in IWD, 
but I don't think this is a bug by any means.

[1] https://doc.freeradius.org/tls_8c_source.html

> This results in iwd throwing a "Fragmented pkt size is outside of allowed boundaries [1, 65536]" error because tls_msg_len is expected to not be zero in `eap_tls_init_request_assembly()`.
>
> Because this change in freeradius does not impact any of my coleagues using macOS, windows, or wpa_supplicant, I think it is safe to say that this is a bug in iwd, and that a length of zero should be allowed.
> I can not seem to find a specific reason why we would need to fail on a length of zero. allowing zero would in this case hit the `tls_msg_len == len` condition and make `eap_tls_init_request_assembly()` return with -ENOMSG, which is then correctly handled in `eap_tls_common_handle_request()`
>
> Greetings
> Laura
>
> ps: I'm not on the list (given that I'm mostly just a (code-savy) user), so please keep me cc-ed on this issue.
>
