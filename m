Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5B812B150
	for <iwd@lists.linux.dev>; Wed, 27 Mar 2024 11:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711540279; cv=none; b=qh5MujLtOUcM/sCNaK1tFg/b5rlEPrbg53Po4myZCXu5YJLgBfrWRu+JCY5W3qU/2DpuArByOBHyxcgGtaE710o+b+PuoxIjZBOqIzybAZ+x6AZJG0zSArS4veVT5uZ03HDSmni2ykrF4MkRLnICNds2r5uzX9VBmqXwj68pv6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711540279; c=relaxed/simple;
	bh=Nr7BarfmhL4X66KFCxvztZELJMaGqY/fWKR/2uunCB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gcfPYGDCOTQxwOV9NOlBkg69w2stdHpNSPAonRO58wOAlK4n/q0/HXk3ssPET92R6bqQfcmjKjdUYiuM0L86YaAu4zL34UVHmElJsjYMQGIM3rUHIsdouB118SqkCn5oiR/SdRCOY6GHcHn9tn8CfzKXEWZeBO6D+fhc1UXeWOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoBsXki2; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoBsXki2"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78a5f7269e3so65535085a.1
        for <iwd@lists.linux.dev>; Wed, 27 Mar 2024 04:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711540277; x=1712145077; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bneV6v19nlJYdFdiTQ0AaYURog1dsAGy3kYPHaUMOoA=;
        b=hoBsXki2rMS/2QQlhGszhAGQemPJ9euAgwmExE74TpCcc7RfsWwT1YQbU+mnSFfM5g
         YMe/6ZJUT/az5rS6X2bmGgN8vcB3dMIpa+owSu1jJIE590yhWtu/kRJDq10TcAKejQaW
         wBTrJDUz99Md3RxY/WhEdSbc3MWZUSfFW0qX1n6KSUAtsrHJEP5Qkpe4MM0+tEIQ5LRG
         vUXvXi77409TFPQV7dFYWI6OwcE9YmcnqLNlVsvnNIBtLhmebhSCX7O3CPcv05XJi6Vo
         T6aJzVUkmhSxnRKj+oywg952SMhkAVtJziGAbGtIjkp+XgQLFerTmeMgon0kPiUZNTIr
         QJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711540277; x=1712145077;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bneV6v19nlJYdFdiTQ0AaYURog1dsAGy3kYPHaUMOoA=;
        b=WKx5MYHD9vITcYUiwbMUnm0o1iaqDozq+Qta0cFiFwg/egxkcOXErB73R/J/JrqQEN
         sZBoTnUxp975Q/3ohZgK+nsyJA2g6clPZwoDD/YA/hOu4WtoXzR+Xa4KU4+zrEoQROGq
         iaYN+SmFCBr4uytECBjqTj8+P1F+p5/xlXjhUVqButbf3P1DOsjwC0sSKYvZ6CixCg/C
         X+ekzahflJvvyuZM7gVWQMKuqWYk2cKGnXLVqzGsTblplNyW5FnSBnAH1UMW+7fDLXCP
         kYbzknt1+zzOHpTgua7VbsA4SuTFrlf6jfD7MHso16VxDGC/KHgJTKXJWHDdJZXBhSEN
         zzlw==
X-Forwarded-Encrypted: i=1; AJvYcCXIC4JBJRHW8cSN+TSVJspMAYk5bd/IemO3QdrzF8+uFBeUiEJcqFCf+ByT6cGjwNERSvs+b3YlcfHI/CUN1aTc+nxv
X-Gm-Message-State: AOJu0YzpKOURayiv0zUd47hC/EDM0/Y+jUQZZ/r5YrnFfAauOSbaPHOt
	jc3NfJYu5+oNx5FpaE2ArXJH1CAo3hwKj0RJz5/Xh/La7NNBOFkRgNIDCNVw
X-Google-Smtp-Source: AGHT+IFxl0DOSmgBdx/jWujdbj058b8zBMG4wbtM/KbDLZgMU3boAb8uq9U6TWZ7cqLL8zZ6nvb37g==
X-Received: by 2002:a0c:df09:0:b0:696:3e05:9c21 with SMTP id g9-20020a0cdf09000000b006963e059c21mr4799582qvl.18.1711540276750;
        Wed, 27 Mar 2024 04:51:16 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id z15-20020a0cfc0f000000b006968ecc002asm3190899qvo.80.2024.03.27.04.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 04:51:16 -0700 (PDT)
Message-ID: <2959f53a-e038-4b17-9b12-26a1901842c0@gmail.com>
Date: Wed, 27 Mar 2024 04:51:14 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Register EAPOL frame listeners earlier
Content-Language: en-US
To: jeremy.whiting@collabora.com, iwd@lists.linux.dev
Cc: ed.smith@collabora.com, alvaro.soliverez@collabora.com
References: <20240326231151.607163-1-jeremy.whiting@collabora.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20240326231151.607163-1-jeremy.whiting@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeremy,

On 3/26/24 4:11 PM, jeremy.whiting@collabora.com wrote:
> From: Ed Smith <ed.smith@collabora.com>
>
> If we register the main EAPOL frame listener as late as the associate
> event, it may not observe ptk_1_of_4. This defeats handling for early
> messages in eapol_rx_packet, which only sees messages once it has been
> registered.
>
> If we move registration to the authenticate event, then the EAPOL
> frame listeners should observe all messages, without any possible
> races. Note that the messages are not actually processed until
> eapol_start() is called, and we haven't moved that call site. All
> that's changing here is how early EAPOL messages can be observed.
> ---
>   src/netdev.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/src/netdev.c b/src/netdev.c
> index 09fac959..fc84c398 100644
> --- a/src/netdev.c
> +++ b/src/netdev.c
> @@ -2982,8 +2982,13 @@ static void netdev_authenticate_event(struct l_genl_msg *msg,
>   						NULL, netdev->user_data);
>   
>   		/* We have sent another CMD_AUTHENTICATE / CMD_ASSOCIATE */
> -		if (ret == 0 || ret == -EAGAIN)
> +		if (ret == 0 || ret == -EAGAIN) {
> +			if (!netdev->sm) {
> +				netdev->sm = eapol_sm_new(netdev->handshake);
> +				eapol_register(netdev->sm);
> +			}
>   			return;
> +		}
>   
>   		retry = kernel_will_retry_auth(status_code,
>   				L_CPU_TO_LE16(auth->algorithm),
> @@ -3099,9 +3104,6 @@ static void netdev_associate_event(struct l_genl_msg *msg,
>   			netdev->ap = NULL;
>   		}
>   
> -		netdev->sm = eapol_sm_new(netdev->handshake);
> -		eapol_register(netdev->sm);
> -
>   		/* Just in case this was a retry */
>   		netdev->ignore_connect_event = false;
>   

I need to have the CI email the original sender so you get notified, but 
as Denis mentioned this still breaks FT because IWD does not use the 
conventional CMD_AUTHENTICATE and instead sends an auth frame using 
CMD_FRAME. This means that there is no authenticate event at all when FT 
is involved. Because of this, no SM gets created (with this patch) which 
breaks rekeys.

After FT authentication netdev_ft_reassociate() is called which issues 
the CMD_CONNECT call (this triggers association). So I think you would 
need to both create the SM similar to where you did here, as well as 
after it gets destroyed in here:

https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/src/netdev.c#n4279

For reference, this is the CI output with this patch:

**Autotest Runner**
Test ID: testrunner
Desc: Runs IWD's autotest framework
Duration: 1868.49 seconds
**Result: FAIL**

Output:
```
testFT-8021x-roam,testFT-FILS,testNetconfigRoam,testPSK-roam,testSAE-roam

Thanks,

James

