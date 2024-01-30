Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F80B33CCF
	for <iwd@lists.linux.dev>; Tue, 30 Jan 2024 03:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706583728; cv=none; b=N4VwVus5UpJPQGLQYX3wXcv20ab20TIsCq6KJEpWUcyH0wJZIjglOv/kAWse9z8DxYAQAmQq/aB24EwvR8249HDrd1ca5HkZaZBVVCLKkDh8uqcEa6Hq8962bEoQqnWMss8uDM3yGaN241QSCvGGVFtYepkmmLz28PYNMFw0xEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706583728; c=relaxed/simple;
	bh=6LiXMRxA7jrOOn2/pzffFPYzsePZlUOxx3MpncxQ8IM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=haG/5ihIQq24W5soGfaZdAN4FJbAqyEQqoshX5T4gfmQJZz0qL+UEhQukXR/tNwTEwOVLg8F1lE14omRjmymrrxlEh5DObNjceBKTu3/QzOvbi53/9DYOPPSxMmeFYjXgsareEhajPlpxELi+HpMXnTbAcVClAdqtLm+8nc8KVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOCkJmDZ; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOCkJmDZ"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-59612e4a21eso1318193eaf.3
        for <iwd@lists.linux.dev>; Mon, 29 Jan 2024 19:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706583726; x=1707188526; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZLk4NSp6Kig03rnQs3kiSZ+Z+tYJx80rPZ+CpB4KVSI=;
        b=TOCkJmDZtJaj0rrkn4BxqNENU6vEPtN9jMaDMBYX4CwNeBLlTifmA8B0OsnEVlCIxx
         7Z+Z07R6I2s96pVeZujz+fMAlPetKyRAHZXCbtCSuIhhW4DYhdK/RxSkerCeeA5voVRp
         L1p+gfZx0Mod7VAZ3XDGGyKEYLytfYWk2XsUtVx21bv6EElOGak37fpWpvF5R3LRG7DD
         RyNOu/GQ5amYpTVZeP0DzUHzi7xjuGmyfVkjxvyu4fIBpNiRczIOWCPkw3RTCiYTOfXs
         gYcx8YMy6fIJr/3mP6yHIaMxg1XeEf6TzCBNP8zZhGCGGVEQbtp8B415xiSKYjp4gOvR
         yLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706583726; x=1707188526;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLk4NSp6Kig03rnQs3kiSZ+Z+tYJx80rPZ+CpB4KVSI=;
        b=Wl1yvdlljm5/T2T7d2OyKfsIAlOOxQxnxUHEgq/3k5oISPdS49bjZgfHlkf9uElKaa
         A6c/0DjroZMf781XkwAzpq3TAsRQ4B1KjFlluB9Ql57q97FXyc+rO6Lt4E0SMC4xikIR
         wlRmUj+Jx+zqtmn+deHi60J0bB3zFIIveaMowdFHGRkKFIJgVd8H4XYtUvzbl9tFronm
         vzmwTs7NOhqerwDjMaddC4BJXXPiWSMY79snj/3SwXuu41fzi4rMRCaVzeydferyXxR4
         pkSJfwf8IZliqxKbhAQvD42NhEJe4Laz9bZmIojhuyHHKDAQ6P/VWzzERKnacFr4aZO3
         C/jw==
X-Gm-Message-State: AOJu0YxSTnM5Y5UMG54UFxd+o2RS5uAm4vju1SgJBHFIRzmQG2pOIm/Z
	K8n8ob1DgxUyufsqQSqOenudnrik+8VGH+3fk1gD2pUxvD6rYi1NOz5JsAZ1
X-Google-Smtp-Source: AGHT+IGZF0E8Aj2Kk5Nuta9Vo0C7ma0KwQaJ2aq1xEKCokYNz7nuqqDJLPkerKGJesj42HvcTVeF0g==
X-Received: by 2002:a4a:c990:0:b0:599:cb42:c4f1 with SMTP id u16-20020a4ac990000000b00599cb42c4f1mr3543717ooq.5.1706583726338;
        Mon, 29 Jan 2024 19:02:06 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id l14-20020a4ae2ce000000b0059a096ee494sm1327830oot.47.2024.01.29.19.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 19:02:06 -0800 (PST)
Message-ID: <1699eb57-26fe-4979-a322-b53c080ecda4@gmail.com>
Date: Mon, 29 Jan 2024 21:02:03 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ap: only accept message 4 after receiving message 2
Content-Language: en-US
To: Mathy Vanhoef <vanhoefm@gmail.com>, iwd@lists.linux.dev
References: <CAFXAJYz3nVT2i3AkoBrCeh+GqkNDrFmriJtfHt=as6j2x4J6jQ@mail.gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CAFXAJYz3nVT2i3AkoBrCeh+GqkNDrFmriJtfHt=as6j2x4J6jQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mathy,

On 1/29/24 10:11, Mathy Vanhoef wrote:
> We found that when IWD is operating in AP mode, it doesn't verify
> whether message 2 was already received before processing message 4.
> 
> I've included a candidate commit message and patch below. My mailing
> client might destroy the spacing, but the small patch should
> illustrate the possible fix.

Ah nice catch.  Thank you.  I created a commit based on your patch / 
description.  Applied now as:
6415420f1c92 ("ap: only accept ptk 4/4 after receiving ptk 2/4")

Regards,
-Denis
