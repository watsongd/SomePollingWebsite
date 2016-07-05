var NewPoll = React.createClass({
  getInitialState: function() {
    return {
      options: [""]
    }
  },
  addOption: function(e) {
    e.preventDefault();
    this.state.options.push("")
    this.setState({
      options: this.state.options
    })
  },
  render: function() {
    var optionsInputs = this.state.options.map(function(option, index) {
      return (
        <div key={index}>
          <input key={index} id={index} name="poll[options][]" type="text" />
          <br />
        </div>
      );
    });
    return (
      <div className="container">
        <form action="/polls" id="new_poll" method="post">
          <input name="authenticity_token" type="hidden" value={this.props.authenticity_token} />
          <label for="poll_title">Title</label>:
          <input id="poll_title" name="poll[title]" type="text" /><br />
          <label>Options:</label>
          <br />
          {optionsInputs}
          <br />
          <p>
            <input type="radio" name="poll[public]" value="false" id="false"/> <br />
            <label for="false">False</label>
          </p>
          <p>
            <input type="radio" name="poll[public]" value="true"  id="true"/> <br />
            <label for="true">True</label>
          </p>
          <button type="button" onClick={this.addOption}>Add option</button>
          <input name="commit" type="submit" value="Create Poll" />
        </form>
      </div>
    )
  }
});