Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD41F28E16
	for <iwd@lists.linux.dev>; Mon,  4 Dec 2023 14:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OR58q2DN"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-67ac4fc7217so8525096d6.0
        for <iwd@lists.linux.dev>; Mon, 04 Dec 2023 06:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701700827; x=1702305627; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6t28JuFdimqfuw5IrXCYZDm4xgOCZo92KnC9MU8gSKI=;
        b=OR58q2DNbmWYKpD/hZ5GdFb0sQL3KMmAlXZdXMT3v6Dam5326ag09otQ4LZNLRrdjm
         YBb1ZAVJAS6CyCtOEH48vKIBVhqG+tuomTClLZuNYzhNdQNISIPEN297UC22QIhDrEoI
         7QPFxdG/CUt6CrmX6vtEh2nzol8jkh9EOSjK6bgIXoEbDsueGaXIo5z3Qmo58QOh/tcW
         g1e4wr28bEYsqj6kEVNvRbkWN9UauPcxMoaW45tVACxFnwd1qsZFVlPbEXSLglHLuxqF
         ebTlPy816Yp8IpMGDCcN0MwKxw+4nktsQ1D2gRzyKFF7eCjn9iyI3+RhVFQHdODRazWT
         C9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701700827; x=1702305627;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6t28JuFdimqfuw5IrXCYZDm4xgOCZo92KnC9MU8gSKI=;
        b=kJt0YUqFw/WC3vmCT7o0dZq1kQx8a9z1SM2MDzQ3dkH0wDa8rPFoQM8SHRg277PL91
         auH92bstDgV53FXqBhUMgwjjtr0X3I3/ne1yJIilrtJfkyU0jGtJ+G73XtT6j4lFwjD2
         M4ZHHlSQLrwMvI7pVUCGDnlqyX+DQvqm7tbyMFm2D9UKUTqr8bVzk3hxOZWcCzl1KUMr
         gQun5wkP4jE1DILSQ7qvHNBsYaGOKi7hH5Rnct8UXw+UjJvIlNBl/h4i0m5A1jvnXHkj
         xXBkDZm3nrD3pKAv82KgWYcNb/eRpxNlmNwoj1zT53VI72G8NnTgRlMvPY8H7dUdt7t+
         rZGw==
X-Gm-Message-State: AOJu0YzMMb3jAbJiqFt8mBfxJGYJP+ex4JRGs5LSnyJGLu0F1I5upkkV
	9h3g0H0BBZwLRbYZHVGui4Z+ZPN6Sb0=
X-Google-Smtp-Source: AGHT+IGs0GDwKZxLmR1/6qseXzB9ThskIjs2asjSOYGEykyp/8i+TU/3HDztwEyFHaELwBVc2xXabw==
X-Received: by 2002:a05:6214:1fd0:b0:66d:1ae6:2a5a with SMTP id jh16-20020a0562141fd000b0066d1ae62a5amr4460872qvb.7.1701700827542;
        Mon, 04 Dec 2023 06:40:27 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id t26-20020a0cb71a000000b0067a49af5ccfsm1576461qvd.119.2023.12.04.06.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 06:40:27 -0800 (PST)
Message-ID: <38a83f9c-6ac6-4862-99b1-128d811a63e5@gmail.com>
Date: Mon, 4 Dec 2023 06:40:24 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SAE password identifiers?
Content-Language: en-US
To: Ronan Pigott <ronan@rjp.ie>, iwd@lists.linux.dev
References: <e3bb952a9c0550a945f002b1dc5c596e370d600d@rjp.ie>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <e3bb952a9c0550a945f002b1dc5c596e370d600d@rjp.ie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ronan,

On 12/4/23 01:56, Ronan Pigott wrote:
> Hi,
>
> I was looking at WPA3 recently which includes a specification of the "WIFI:" URI
> scheme. I was interseted in creating iwd .network configurations from these URI
> but afaict iwd is missing support for SAE password identifiers, which may appear
> in the URI. Is iwd capable of connecting to these networks? If so, how can it be
> specified in the config?

No currently there is no support for password identifiers in IWD's SAE 
implementation. It appears to be somewhat simple to add, an extra IE in 
the SAE exchange and adding the identifier to the PWE hashing.

>
> Thanks,
> Ronan
>
