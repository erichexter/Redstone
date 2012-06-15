using System.Web.Mvc;
using ShortBus;

namespace UI.Controllers
{
    using System.Web.Mvc;
    using ShortBus;

        public abstract class BaseController : Controller
        {
            readonly IMediator _mediator;

            protected BaseController(IMediator mediator)
            {
                _mediator = mediator;
            }

            protected Response<TResult> Query<TResult>(IQuery<TResult> query)
            {
                return _bus.Request(query);
            }

            protected void Command(object command)
            {
                _bus.Send(command);
            }

            protected ViewResult View<TData>(Response<TData> model)
            {
                return View(string.Empty, model);
            }

            protected ViewResult View<TData>(string viewName, Response<TData> model)
            {
                if (model.HasException())
                    return base.View("~/views/shared/error.cshtml", model);

                return View(viewName, model.Data);
            }

            protected PartialViewResult PartialView<TData>(Response<TData> model)
            {
                return PartialView(string.Empty, model);
            }

            protected PartialViewResult PartialView<TData>(string viewName, Response<TData> model)
            {
                if (model.HasException())
                    return base.PartialView("~/views/shared/errorpartial.cshtml", model);

                return PartialView(viewName, model.Data);
            }
        }
    }