Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703D724F59
	for <iwd@lists.linux.dev>; Wed,  2 Nov 2022 20:13:33 +0000 (UTC)
Received: by mail-qt1-f170.google.com with SMTP id e15so45315qts.1
        for <iwd@lists.linux.dev>; Wed, 02 Nov 2022 13:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=65gAdoNFwMruRDeUMnd4m+xnfKXKJ/SnKoa8/VnvxCY=;
        b=H8lQisBY9jeKphgpnGmQpgcsVY8UxDJuyYPGhVDV5l+PZJcXxaQfHLg/xRloIRXn9x
         uH/NWWRqn1JlYqqqHFFICRRUsgpQiBtOuDOgEwsoPQcnTmoj6f6fYGZNE/4wma5rYNHl
         KrbYKT7WnTPCcD1TqUwYGgT1Jn6uo6jxx6SCZzoUp2Axz4xcodbsv+qKNfr2xxZeuU6x
         Z9kZqnz0Rcau/TDvCl92jZYHqyS8ZPi64Ko7bYZF2I6gXsffhIDe1B6Xj198LCXpR6BD
         10+EPdjxmgslm3W6DT9s8R4sFOpy5R36la4WhUzo70XuNcPLUb/84h5ZjGyMQm5YXr4b
         1wbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=65gAdoNFwMruRDeUMnd4m+xnfKXKJ/SnKoa8/VnvxCY=;
        b=D52fiKnzgufUWh80g/k1J0TIpc/7pCkXy+tI4CTyfLzorQjo8pJYzdn6wPB01xtfiO
         mFzxoW9ekUcB8qDtb0dIs9KU47Fz5AxnonGazVhTw4paLYZzx/sR6aQ8/HEKDSTsv6kE
         SruL11Ui3Y9v1vHbPAkH/aXrFOt9Zwc9DlTFeZDOyCZepKFWXA+p0iEa9y5DFpG/0R45
         SqE1LHsdvZEA5AzMLFAGskja3cJC3KjeEiEcl0QptRZ51iQGc5p6uWPv++SDbUpTUYXc
         T2/NZa2iyr2hkyWYv76EBXgr86z9wJAMhenSdCLuxI8GPb2MdshASoej9Gix4ghukInf
         n0kw==
X-Gm-Message-State: ACrzQf2xXjfHLmamqqLgczLF9+dDxtx3R88unU2qsQ/prsAPaGE+QetE
	Php9CYcyxQOWGpGBpmNU5StUx1Axupf/7ONWnJQ=
X-Google-Smtp-Source: AMsMyM4KPd5nfHKYB8ZJTVCsPK4dDvh3pWbbGkFnateUK3A91uMcp4DAZQLnzMJ7dFjjBwgMjLBmpe7PiY0/9ACW04U=
X-Received: by 2002:ac8:57d0:0:b0:39c:f3a8:7c78 with SMTP id
 w16-20020ac857d0000000b0039cf3a87c78mr21732286qta.470.1667420012372; Wed, 02
 Nov 2022 13:13:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221102092156.71357-1-env252525@gmail.com> <ffc95d8d-78c5-7baf-c5be-0ed35e36895e@gmail.com>
In-Reply-To: <ffc95d8d-78c5-7baf-c5be-0ed35e36895e@gmail.com>
From: eNV25 <env252525@gmail.com>
Date: Thu, 3 Nov 2022 01:43:19 +0530
Message-ID: <CANpHdjDKekPD7fbR8nmfZpZD2J=R3acnJAzMo+RATED0aqjc+g@mail.gmail.com>
Subject: Re: [PATCH 1/2] client: fix spurious newlines in station show
To: Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 3, 2022 at 1:29 AM Denis Kenzior <denkenz@gmail.com> wrote:
> Can I get a proper full name please?  I can't take this into the repo otherwise.

My name is Neehar Vijay.

Do I need to send a v2 patch with the name?

> Regards,
> -Denis
