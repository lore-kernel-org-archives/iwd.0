Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77635339D
	for <iwd@lists.linux.dev>; Mon,  5 Aug 2024 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722867675; cv=none; b=TXYp7Bzk2HBU2BZ5u+unE7z0zPWZ1Uzf3mW4T9uk57J1C7gQrFZ+de4tK14MN/B4IWppLxk9gK//snRuqoqH+WDPsTKk5rkr6EOkjLJm/CJ4yy4/jMw6/5jDK1UnxyjnyNhGL6SnSuUyR4PILFM5pQ+O5IKIig4i+Gwm8yJa0Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722867675; c=relaxed/simple;
	bh=1VfFtr2niazYDwLM72zyl4YpqWHV9EvNsbyeNMyE2Jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nBoN79CRxPfci+9R/fbMhUO9CS9FhbpYScEqdGI9KM8lf+HCBma3k0Gegl8HRYxbbUFtYcSbrfnzJnabIr2dcqjvDm/xgUhRoY1TqmfAPX0+fAf/IDIGa8NsEr1DFqXlRWISktJkEN9a/Rg1okA2SgYQ2/Qj+lcDypjJIysccLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2/4qpuB; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2/4qpuB"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a1dcc7bc05so654111885a.0
        for <iwd@lists.linux.dev>; Mon, 05 Aug 2024 07:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722867672; x=1723472472; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NIrdfWuLwkelnmPeOkf/5hJ2M3zM3eJOAXR56ywzB9I=;
        b=D2/4qpuB2WlPt2M/NjiLWbVMqblXNdDQqKxdiGjuOv85vRjXzBoJno9ufuqM/xAlcH
         rO7zQAUeTOsdx9RA/R/CXiYpxdxIPFIN2V0hRgm80k/Y7V4tjYVQfV7Z/mNC0dRqwV7x
         dopkydK49tcvVOAwn3J3em0G4YNb7D5mv9yLf+CCodslCOLdku6Aem0olmo4pn4r5ZFO
         G7gstvGrQsyFQDWlmufkKwqLKslqC3qLl1WkPgWTt+AZD4yVxSPklHQ7Ust/d46LJsDC
         S4dSn4RDxjaVwFnJzHYHGdqdMRe6dXkiv9YXlz5TvEEScijuMJ8KgaxVP/WsqDFI7pZU
         OGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722867672; x=1723472472;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NIrdfWuLwkelnmPeOkf/5hJ2M3zM3eJOAXR56ywzB9I=;
        b=o2diJkck4dU56GitGjPEMIl94div8Fn465q6IiZzSXuItJD9mTlvqOCzP8waPGvanz
         njW85CeGRX6NcsdRzUwGUNjDPnkIhM/OPTydW5IxbTG6N4UmAaXP9HfBFR80JlugdYdX
         pDpNkmC1hQlIvQOCNd5LA/Aqk/sIB9m+kax7BaVg2Egq9RbHOJBj5EaPneF+dmcja+fo
         uLL4VnzgsjloO3vhkDDpHd5lSPh80l9Tism5tIOLn5VdHw8HBeeYt2L89KjLtJ26ZFWO
         QFq1cdgH3QVGfBJm8fyTz0YvsFeUtNjvPZkmv2jFRSyvL569WiJDA4IYD5qC3wuHreiq
         QZcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW702dJyxIiLtgQq5RJOQLemLjktOW/ykrtWlzJ/Svythh+BJPKQZaKC5n/nj6vu6p/4d7fGOJYfqmGgyaVfmTIRGUl
X-Gm-Message-State: AOJu0YxCCGqGHPouFqW/HNzURGV4y4IkuOy5tnuqGQBYLTH6g10NUW/a
	ugayrT5mxo16HNyaXef/pOqBWCwqfSButvsMtOjW/tQVHr6FhZST
X-Google-Smtp-Source: AGHT+IEgrYT0G6DC2aSVWgjWFxMOPt/nbT8HqgE2K4AKmiLAgAPUblFn5mO5l5PU3JCvkmMSocEgDg==
X-Received: by 2002:a05:620a:2a13:b0:79d:945c:8d5e with SMTP id af79cd13be357-7a34efe2795mr1655841285a.49.1722867672533;
        Mon, 05 Aug 2024 07:21:12 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f6dc8ffsm358607285a.26.2024.08.05.07.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 07:21:12 -0700 (PDT)
Message-ID: <2e5f6f43-d8cc-408f-b0e0-89d40b6adbf1@gmail.com>
Date: Mon, 5 Aug 2024 07:21:10 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] monitor: Decode RMNet Mux Identifier
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20240805140721.57518-1-denkenz@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20240805140721.57518-1-denkenz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Denis,

On 8/5/24 7:07 AM, Denis Kenzior wrote:
> ---
>   monitor/nlmon.c | 7 +++++++
>   1 file changed, 7 insertions(+)
All look good to me.
