Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26546118
	for <iwd@lists.linux.dev>; Fri, 24 Mar 2023 14:20:01 +0000 (UTC)
Received: from smtpclient.apple (p4ff9fee6.dip0.t-ipconnect.de [79.249.254.230])
	by mail.holtmann.org (Postfix) with ESMTPSA id A000DCECC7;
	Fri, 24 Mar 2023 15:12:58 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.2\))
Subject: Re: [PATCH] man: enclose referenced man page names in bold
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20230321161905.161909-1-nl6720@gmail.com>
Date: Fri, 24 Mar 2023 15:12:58 +0100
Cc: iwd@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <94DE8A03-1C36-424C-B5E2-A1A0DF2CA971@holtmann.org>
References: <20230321161905.161909-1-nl6720@gmail.com>
To: nl6720 <nl6720@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.2)

Hi,

> On Mar 21, 2023, at 17:19, nl6720 <nl6720@gmail.com> wrote:
> 
> Man page parsers will autolink appropriately formated man page
> references. The most common format is to have the page name in bold
> followed by the section number in brackets.
> ---
> src/iwd.ap.rst      |  8 ++++----
> src/iwd.config.rst  |  4 ++--
> src/iwd.debug.rst   |  2 +-
> src/iwd.network.rst |  8 ++++----
> src/iwd.rst         | 14 +++++++-------
> 5 files changed, 18 insertions(+), 18 deletions(-)

can you fix your git config and add real name info to the author
information please.

Regards

Marcel

